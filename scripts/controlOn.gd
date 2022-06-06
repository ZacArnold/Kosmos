extends Area


func _on_goal_body_entered(body):
	if body.name == "player":
		global.controlAllowed = true
