extends KinematicBody


##########Variable Setup##########
const MAXSPEED = 12
const FRICTION = 0.075
const ACCELERATION = 0.075
const JUMPPOWER = 30
const GRAVITY = 98/1.5
const PIVOTSPEED = 90
var velocity = Vector3.ZERO
var playerDirection = 0
var rotateVelocity = Vector3.ZERO
var pivotVelocity = Vector3.ZERO
##################################


func _physics_process(delta):
	var inputVelocity = Vector3.ZERO
	var inputRotateVelocity = Vector3.ZERO
	var inputPivotVelocity = Vector3.ZERO
	
	
	##########Rotation Control##########
	if Input.is_action_just_pressed("camera_pivot_left"):
		inputPivotVelocity.y -= 1
		playerDirection -= 1
	elif Input.is_action_just_pressed("camera_pivot_left"):
		playerDirection -= 1
	elif Input.is_action_just_pressed("camera_pivot_left"):
		playerDirection -= 1
	elif Input.is_action_just_pressed("camera_pivot_left"):
		playerDirection = 0
	
	if Input.is_action_just_pressed("camera_pivot_right"):
		inputPivotVelocity.y += 1
		playerDirection += 1
	elif Input.is_action_just_pressed("camera_pivot_right"):
		playerDirection += 1
	elif Input.is_action_just_pressed("camera_pivot_right"):
		playerDirection += 1
	elif Input.is_action_just_pressed("camera_pivot_right"):
		playerDirection = 0
	
	#Keeps direction set within range
	if playerDirection == 4 or playerDirection == -4:
		playerDirection = 0
	
	#Velocity maxed at set speed
	inputPivotVelocity = inputPivotVelocity.normalized() * PIVOTSPEED
	
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
	####################################
	
	
	##########Player Rotation Control##########
	if Input.is_action_pressed("forward"):
		inputRotateVelocity.x -= 1
	if Input.is_action_pressed("backward"):
		inputRotateVelocity.x += 1
	if Input.is_action_pressed("left"):
		inputRotateVelocity.z += 1
	if Input.is_action_pressed("right"):
		inputRotateVelocity.z -= 1
	###########################################
	
	
	##########2D Movement Control##########
	if playerDirection == 0:
		if Input.is_action_pressed("forward"):
			inputVelocity.z -= 1
		if Input.is_action_pressed("backward"):
			inputVelocity.z += 1
		if Input.is_action_pressed("left"):
			inputVelocity.x -= 1
		if Input.is_action_pressed("right"):
			inputVelocity.x += 1
	
	if playerDirection == 1 or playerDirection == -3:
		if Input.is_action_pressed("forward"):
			inputVelocity.x -= 1
		if Input.is_action_pressed("backward"):
			inputVelocity.x += 1
		if Input.is_action_pressed("left"):
			inputVelocity.z += 1
		if Input.is_action_pressed("right"):
			inputVelocity.z -= 1
	
	if playerDirection == -1 or playerDirection == 3:
		if Input.is_action_pressed("forward"):
			inputVelocity.x += 1
		if Input.is_action_pressed("backward"):
			inputVelocity.x -= 1
		if Input.is_action_pressed("left"):
			inputVelocity.z -= 1
		if Input.is_action_pressed("right"):
			inputVelocity.z += 1
	
	if playerDirection == 2 or playerDirection == -2:
		if Input.is_action_pressed("forward"):
			inputVelocity.z += 1
		if Input.is_action_pressed("backward"):
			inputVelocity.z -= 1
		if Input.is_action_pressed("left"):
			inputVelocity.x += 1
		if Input.is_action_pressed("right"):
			inputVelocity.x -= 1
	
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
	
	#Moves and rotates the player with accelerating and deccelerating velocity
	velocity = move_and_slide(velocity,Vector3.UP)
	$MeshInstance.rotate_z(deg2rad(rotateVelocity.z))
	$MeshInstance.rotate_x(deg2rad(rotateVelocity.x))
	#######################################
	
	
	##########Jumping & Gravity Control##########
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMPPOWER
	velocity.y -= GRAVITY * delta
	#############################################
