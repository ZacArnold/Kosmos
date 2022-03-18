extends Area

onready var global = get_node("/root/Global")

func _on_fallZone_body_entered(body):
	if body.name == "player":
		global.controlAllowed = false
		get_tree().reload_current_scene()
