extends Spatial

#Var setup
const FRICTION = 0.075
const ACCELERATION = 0.075
var maxSpeed = 0
var pivotVelocity = Vector3.ZERO

func _physics_process(delta):
	var inputPivotVelocity = Vector3.ZERO
	
	#Rotation Control
	if Input.is_action_just_pressed("camera_pivot_left"):
		maxSpeed = -90
		inputPivotVelocity.y -= 1
	if Input.is_action_just_pressed("camera_pivot_right"):
		maxSpeed = 90
		inputPivotVelocity.y += 1
	
	#Velocity maxed at set speed
	inputPivotVelocity = inputPivotVelocity.normalized() * maxSpeed
	
	# If there's input, accelerate to the input velocity
	if inputPivotVelocity.length() > 0:
		pivotVelocity = pivotVelocity.linear_interpolate(inputPivotVelocity, ACCELERATION)
	else:
	# If there's no input, slow down to (0, 0)
		pivotVelocity = pivotVelocity.linear_interpolate(Vector3.ZERO, FRICTION)
	
	
	#Rotates Camera
	rotate_y(deg2rad(pivotVelocity.y))
