extends KinematicBody


var velocity = Vector3.ZERO
var speed = 10
var friction = 0.05
var acceleration = 0.1

func _physics_process(delta):
	var input_velocity = Vector3.ZERO
	
	if Input.is_action_pressed("up"):
		input_velocity.z -= 1
		$MeshInstance.rotate_x(deg2rad(-10))
	if Input.is_action_pressed("down"):
		input_velocity.z += 1
		$MeshInstance.rotate_x(deg2rad(10))
	if Input.is_action_pressed("left"):
		input_velocity.x -= 1
		$MeshInstance.rotate_z(deg2rad(10))
	if Input.is_action_pressed("right"):
		input_velocity.x += 1
		$MeshInstance.rotate_z(deg2rad(-10))
	
	input_velocity = input_velocity.normalized() * speed
	
	# If there's input, accelerate to the input velocity
	if input_velocity.length() > 0:
		velocity = velocity.linear_interpolate(input_velocity, acceleration)
	else:
	# If there's no input, slow down to (0, 0)
		velocity = velocity.linear_interpolate(Vector3.ZERO, friction)
	velocity = move_and_slide(velocity)
