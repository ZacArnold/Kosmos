extends CanvasLayer

signal transitioned

func transition():
	$animationPlayer.play("fadeToBlack")

func _on_animationPlayer_animation_finished(anim_name):
	if anim_name == "fadeToBlack":
		emit_signal("transitioned")
		$animationPlayer.play("fadeToNormal")
