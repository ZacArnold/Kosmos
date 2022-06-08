extends GridMap

func _on_levelStart_body_entered(body):
	if body.name == "player":
		if global.controlAllowed == false:
			if get_tree().current_scene.name == "level_1":
				$animationPlayer.play("wallRise")
				$audioStreamPlayer.play()
			if get_tree().current_scene.name == "level_2":
				$animationPlayer.play("wallRise_2")
				$audioStreamPlayer.play()
			if get_tree().current_scene.name == "level_3":
				$animationPlayer.play("wallRise_3")
				$audioStreamPlayer.play()
			if get_tree().current_scene.name == "level_4":
				$animationPlayer.play("wallRise_4")
				$audioStreamPlayer.play()
			if get_tree().current_scene.name == "level_5":
				$animationPlayer.play("wallRise_5")
				$audioStreamPlayer.play()
