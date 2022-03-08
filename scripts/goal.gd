extends Area

func _process(delta):
	rotate_y(deg2rad(1))

func _on_goal_body_entered(body):
	if body.name == "player":
		get_tree().change_scene("res://levels/level_1.tscn")
