extends Area

export (String, FILE) var nextLevel = "res://levels/level_2.tscn"


func _on_goal_body_entered(body):
	if body.name == "player":
		# warning-ignore:return_value_discarded
		get_tree().change_scene(nextLevel)
		global.secretFound = false
