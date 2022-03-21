extends KinematicBody

onready var global = get_node("/root/Global")


##########Variable Setup##########
const FRICTION = 0.075
const ACCELERATION = 0.075
const JUMPPOWER = 15
const GRAVITY = 9.8
const PIVOTSPEED = 90

var velocity = Vector3.ZERO
var rotateVelocity = Vector3.ZERO
var pivotVelocity = Vector3.ZERO
var jumpVelocity = Vector3.ZERO

var maxSpeed = 12
var playerDirection = 0
##################################


func _physics_process(delta):
	var inputVelocity = Vector3.ZERO
	var inputRotateVelocity = Vector3.ZERO
	var inputPivotVelocity = Vector3.ZERO
	
	#Slower Mid-air Movement
	if not is_on_floor():
		maxSpeed = 10
	else: 
		maxSpeed = 12
	
	
	##########Camera Control##########
	if Input.is_action_just_pressed("camera_pivot_left") and global.controlAllowed == true:
		inputPivotVelocity.y -= 1
		playerDirection -= 1
	
	if Input.is_action_just_pressed("camera_pivot_right") and global.controlAllowed == true:
		inputPivotVelocity.y += 1
		playerDirection += 1
	
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
	if playerDirection == 0 and global.controlAllowed == true:
		if Input.is_action_pressed("forward") and global.controlAllowed == true:
			inputRotateVelocity.x -= 1
		if Input.is_action_pressed("backward") and global.controlAllowed == true:
			inputRotateVelocity.x += 1
		if Input.is_action_pressed("left") and global.controlAllowed == true:
			inputRotateVelocity.z += 1
		if Input.is_action_pressed("right") and global.controlAllowed == true:
			inputRotateVelocity.z -= 1
	
	if playerDirection == 1 or playerDirection == -3 and global.controlAllowed == true:
		if Input.is_action_pressed("forward") and global.controlAllowed == true:
			inputRotateVelocity.z += 1
		if Input.is_action_pressed("backward") and global.controlAllowed == true:
			inputRotateVelocity.z -= 1
		if Input.is_action_pressed("left") and global.controlAllowed == true:
			inputRotateVelocity.x += 1
		if Input.is_action_pressed("right") and global.controlAllowed == true:
			inputRotateVelocity.x -= 1
	
	if playerDirection == -1 or playerDirection == 3 and global.controlAllowed == true:
		if Input.is_action_pressed("forward") and global.controlAllowed == true:
			inputRotateVelocity.z -= 1
		if Input.is_action_pressed("backward") and global.controlAllowed == true:
			inputRotateVelocity.z += 1
		if Input.is_action_pressed("left") and global.controlAllowed == true:
			inputRotateVelocity.x -= 1
		if Input.is_action_pressed("right") and global.controlAllowed == true:
			inputRotateVelocity.x += 1
	
	if playerDirection == 2 or playerDirection == -2 and global.controlAllowed == true:
		if Input.is_action_pressed("forward") and global.controlAllowed == true:
			inputRotateVelocity.x += 1
		if Input.is_action_pressed("backward") and global.controlAllowed == true:
			inputRotateVelocity.x -= 1
		if Input.is_action_pressed("left") and global.controlAllowed == true:
			inputRotateVelocity.z -= 1
		if Input.is_action_pressed("right") and global.controlAllowed == true:
			inputRotateVelocity.z += 1
	###########################################
	
	
	##########2D Movement Control##########
	if playerDirection == 0 and global.controlAllowed == true:
		if Input.is_action_pressed("forward") and global.controlAllowed == true:
			inputVelocity.z -= 1
		if Input.is_action_pressed("backward") and global.controlAllowed == true:
			inputVelocity.z += 1
		if Input.is_action_pressed("left") and global.controlAllowed == true:
			inputVelocity.x -= 1
		if Input.is_action_pressed("right") and global.controlAllowed == true:
			inputVelocity.x += 1
	
	if playerDirection == 1 or playerDirection == -3 and global.controlAllowed == true:
		if Input.is_action_pressed("forward") and global.controlAllowed == true:
			inputVelocity.x -= 1
		if Input.is_action_pressed("backward") and global.controlAllowed == true:
			inputVelocity.x += 1
		if Input.is_action_pressed("left") and global.controlAllowed == true:
			inputVelocity.z += 1
		if Input.is_action_pressed("right") and global.controlAllowed == true:
			inputVelocity.z -= 1
	
	if playerDirection == -1 or playerDirection == 3 and global.controlAllowed == true:
		if Input.is_action_pressed("forward") and global.controlAllowed == true:
			inputVelocity.x += 1
		if Input.is_action_pressed("backward") and global.controlAllowed == true:
			inputVelocity.x -= 1
		if Input.is_action_pressed("left") and global.controlAllowed == true:
			inputVelocity.z -= 1
		if Input.is_action_pressed("right") and global.controlAllowed == true:
			inputVelocity.z += 1
	
	if playerDirection == 2 or playerDirection == -2 and global.controlAllowed == true:
		if Input.is_action_pressed("forward") and global.controlAllowed == true:
			inputVelocity.z += 1
		if Input.is_action_pressed("backward") and global.controlAllowed == true:
			inputVelocity.z -= 1
		if Input.is_action_pressed("left") and global.controlAllowed == true:
			inputVelocity.x += 1
		if Input.is_action_pressed("right") and global.controlAllowed == true:
			inputVelocity.x -= 1
	#######################################
	
	
	##########Gravity##########
	if not is_on_floor() and get_tree().current_scene.name != "startScreen":
		velocity.y -= GRAVITY * (2 * delta)
	else:
		velocity.y = 0
	###########################
	
	
	##########Jumping Control##########
	if global.controlAllowed == true:
		if Input.is_action_pressed("jump") and is_on_floor():
			velocity.y = JUMPPOWER
	###################################
	
	
	##########Smooth Movement##########
	#Velocity maxed at set speed
	inputVelocity = inputVelocity.normalized() * maxSpeed
	inputRotateVelocity = inputRotateVelocity.normalized() * maxSpeed
	
	# If there's input, accelerate to the input velocity
	if inputVelocity.length() > 0:
		velocity.x = lerp(velocity.x, inputVelocity.x, ACCELERATION)
		velocity.z = lerp(velocity.z, inputVelocity.z, ACCELERATION)
		rotateVelocity = rotateVelocity.linear_interpolate(inputRotateVelocity, ACCELERATION)
	else:
	# If there's no input, slow down to (0, 0)
		velocity.x = lerp(velocity.x, 0, FRICTION)
		velocity.z = lerp(velocity.z, 0, FRICTION)
		rotateVelocity = rotateVelocity.linear_interpolate(Vector3.ZERO, FRICTION)
	
	#Moves and rotates the player with accelerating and deccelerating velocity
	velocity = move_and_slide(velocity, Vector3.UP)
	$meshInstance.rotate_z(deg2rad(rotateVelocity.z))
	$meshInstance.rotate_x(deg2rad(rotateVelocity.x))
	###################################
	
	
	
	#DEBUG
	if velocity != Vector3.ZERO:
		print("Velocity:      ", velocity)
