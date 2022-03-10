extends StaticBody

func _process(delta):
	#Velocity maxed at set speed
	inputVelocity = inputVelocity.normalized() * MAXSPEED
	
	# If there's input, accelerate to the input velocity
	if inputVelocity.length() > 0:
		velocity = velocity.linear_interpolate(inputVelocity, ACCELERATION)
	else:
	# If there's no input, slow down to (0, 0)
		velocity = velocity.linear_interpolate(Vector3.ZERO, FRICTION)
	
	#Moves and rotates the player with accelerating and deccelerating velocity
	velocity = move_and_slide(velocity,Vector3.UP)
