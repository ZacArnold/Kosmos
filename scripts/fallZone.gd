extends Area

onready var global = get_node("/root/Global")

func _on_fallZone_body_entered(body):
	if body.name == "player":
		global.controlAllowed = false
		# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
