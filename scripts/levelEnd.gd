extends Area

onready var global = get_node("/root/Global")

func _on_goal_body_entered(body):
	if body.name == "player":
		global.controlAllowed = false
