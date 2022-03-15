extends KinematicBody


##########Variable Setup##########
const FRICTION = 0.075
const ACCELERATION = 0.075
const JUMPPOWER = 10
const GRAVITY = 9.8
const PIVOTSPEED = 90
var velocity = Vector3.ZERO
var rotateVelocity = Vector3.ZERO
var pivotVelocity = Vector3.ZERO
var jumpVelocity = Vector3.ZERO
var MAXSPEED = 12
var playerDirection = 0
var jumpAllowed = true
##################################


func _physics_process(delta):
	var inputVelocity = Vector3.ZERO
	var inputRotateVelocity = Vector3.ZERO
	var inputPivotVelocity = Vector3.ZERO
	
	#No Jump on first level
	if get_tree().current_scene.name == "level_1":
		jumpAllowed = false
	#No Gravity on start screen
	elif get_tree().current_scene.name == "startScreen":
		jumpAllowed = false
		velocity = Vector3.ZERO
		rotateVelocity = Vector3.ZERO
		pivotVelocity = Vector3.ZERO
		jumpVelocity = Vector3.ZERO
		MAXSPEED = 0
	else:
		jumpAllowed = true
	
	#Slower Mid-air Movement
	if not is_on_floor():
		MAXSPEED = 6
	else: 
		MAXSPEED = 12
	
	
	##########Camera Control##########
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
	$pivot.rotate_y(deg2rad(pivotVelocity.y))
	##################################
	
	
	##########Player Rotation Control##########
	if playerDirection == 0:
		if Input.is_action_pressed("forward"):
			inputRotateVelocity.x -= 1
		if Input.is_action_pressed("backward"):
			inputRotateVelocity.x += 1
		if Input.is_action_pressed("left"):
			inputRotateVelocity.z += 1
		if Input.is_action_pressed("right"):
			inputRotateVelocity.z -= 1
	
	if playerDirection == 1 or playerDirection == -3:
		if Input.is_action_pressed("forward"):
			inputRotateVelocity.z += 1
		if Input.is_action_pressed("backward"):
			inputRotateVelocity.z -= 1
		if Input.is_action_pressed("left"):
			inputRotateVelocity.x += 1
		if Input.is_action_pressed("right"):
			inputRotateVelocity.x -= 1
	
	if playerDirection == -1 or playerDirection == 3:
		if Input.is_action_pressed("forward"):
			inputRotateVelocity.z -= 1
		if Input.is_action_pressed("backward"):
			inputRotateVelocity.z += 1
		if Input.is_action_pressed("left"):
			inputRotateVelocity.x -= 1
		if Input.is_action_pressed("right"):
			inputRotateVelocity.x += 1
	
	if playerDirection == 2 or playerDirection == -2:
		if Input.is_action_pressed("forward"):
			inputRotateVelocity.x += 1
		if Input.is_action_pressed("backward"):
			inputRotateVelocity.x -= 1
		if Input.is_action_pressed("left"):
			inputRotateVelocity.z -= 1
		if Input.is_action_pressed("right"):
			inputRotateVelocity.z += 1
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
	velocity.y = 0
	$MeshInstance.rotate_z(deg2rad(rotateVelocity.z))
	$MeshInstance.rotate_x(deg2rad(rotateVelocity.x))
	#######################################
	
	
	##########Jumping & Gravity Control##########
	if jumpAllowed == true:
		if Input.is_action_pressed("jump") and is_on_floor():
			jumpVelocity.y = JUMPPOWER
	if not is_on_floor():
		jumpVelocity.y -= GRAVITY * delta
	jumpVelocity = move_and_slide(jumpVelocity, Vector3.UP)
	jumpVelocity.x = 0
	jumpVelocity.z = 0
	#############################################
	
	
	#print(velocity)
	print(jumpVelocity)

