extends Button

#Start screen button
func _on_Button_pressed():
	if get_tree().current_scene.name == "startScreen":
		get_tree().change_scene("res://levels/level_1.tscn")
