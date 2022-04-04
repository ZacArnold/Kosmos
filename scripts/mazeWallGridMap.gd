extends GridMap

onready var global = get_node("/root/Global")

func _on_levelStart_body_entered(body):
	if body.name == "player":
		if global.controlAllowed == false:
			if get_tree().current_scene.name == "level_1":
				$animationPlayer.play("wallRise")
			if get_tree().current_scene.name == "level_2":
				$animationPlayer.play("wallRise2")