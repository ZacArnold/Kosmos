extends Area

func _on_fallZone_body_entered(body):
	if body.name == "player":
		get_tree().reload_current_scene()
