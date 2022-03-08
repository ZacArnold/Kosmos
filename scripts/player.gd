extends KinematicBody

#Var setup
const MAXSPEED = 12
const FRICTION = 0.075
const ACCELERATION = 0.075
const JUMPSPEED = 30
const GRAVITY = 98/1.5
var pivotSpeed = 0
var velocity = Vector3.ZERO
var rotateVelocity = Vector3.ZERO
var pivotVelocity = Vector3.ZERO

func _physics_process(delta):
	var inputVelocity = Vector3.ZERO
	var inputRotateVelocity = Vector3.ZERO
	var inputPivotVelocity = Vector3.ZERO
	
	#Rotation Control
	if Input.is_action_just_pressed("camera_pivot_left"):
		pivotSpeed = 90
		inputPivotVelocity.y -= 1
	if Input.is_action_just_pressed("camera_pivot_right"):
		pivotSpeed = 90
		inputPivotVelocity.y += 1
	
	#Velocity maxed at set speed
	inputPivotVelocity = inputPivotVelocity.normalized() * pivotSpeed
	
	# If there's input, accelerate to the input velocity
	if inputPivotVelocity.length() > 0:
		pivotVelocity = pivotVelocity.linear_interpolate(inputPivotVelocity, ACCELERATION)
	elif inputPivotVelocity.length() < 0:
		pivotVelocity = pivotVelocity.linear_interpolate(inputPivotVelocity, ACCELERATION)
	else:
	# If there's no input, slow down to (0, 0)
		pivotVelocity = pivotVelocity.linear_interpolate(Vector3.ZERO, FRICTION)
	
	#Rotates Camera
	rotate_y(deg2rad(pivotVelocity.y))
	
	
	#2D Movement Control
	if Input.is_action_pressed("forward"):
		inputVelocity.z -= 1
		inputRotateVelocity.x -= 1
	if Input.is_action_pressed("backward"):
		inputVelocity.z += 1
		inputRotateVelocity.x += 1
	if Input.is_action_pressed("left"):
		inputVelocity.x -= 1
		inputRotateVelocity.z += 1
	if Input.is_action_pressed("right"):
		inputVelocity.x += 1
		inputRotateVelocity.z -= 1
	
	#Velocity maxed at set speed
	inputVelocity = inputVelocity.normalized() * MAXSPEED
	inputRotateVelocity = inputRotateVelocity.normalized() * MAXSPEED
	
	# If there's input, accelerate to the input velocity
	if inputVelocity.length() > 0:
		velocity = velocity.linear_interpolate(inputVelocity, ACCELERATION)
		rotateVelocity = rotateVelocity.linear_interpolate(inputRotateVelocity, ACCELERATION)
	else:
	# If there's no input, slow down to (0, 0)
		velocity = velocity.linear_interpolate(Vector3.ZERO, FRICTION)
		rotateVelocity = rotateVelocity.linear_interpolate(Vector3.ZERO, FRICTION)
	
	#Jumping movement control
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPSPEED
	
	#Gravity
	velocity.y -= GRAVITY * delta
	
	#Moves and rotates the player with accelerating and deccelerating velocity
	velocity = move_and_slide(velocity,Vector3.UP)
	$MeshInstance.rotate_z(deg2rad(rotateVelocity.z))
	$MeshInstance.rotate_x(deg2rad(rotateVelocity.x))
