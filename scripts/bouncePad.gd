extends StaticBody



func _on_bouncePad_body_entered(body):
	if body.name == "player":
		$animationPlayer.play("bounce")
		$audioStreamPlayer.play()
