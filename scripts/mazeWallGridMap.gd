extends GridMap

func _on_levelStart_body_entered(body):
	if body.name == "player":
		if global.controlAllowed == false:
			$animationPlayer.play("wallRise")
			$audioStreamPlayer.play()
