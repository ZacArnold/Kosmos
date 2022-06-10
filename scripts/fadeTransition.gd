extends CanvasLayer

signal transitioned


func transition():
	$animationPlayer.play("fadeToBlack")

func _ready():
	if get_tree().current_scene.name == "level_2" or get_tree().current_scene.name == "level_3" or get_tree().current_scene.name == "level_4" or get_tree().current_scene.name == "level_5":
		$animationPlayer.play("fadeToNormal")

func _on_animationPlayer_animation_finished(anim_name):
	if anim_name == "fadeToBlack":
		emit_signal("transitioned")

func _on_controlOff_body_entered(body):
	if body.name == "player":
		get_parent().get_node("bgMusic").stop()
		get_parent().get_node("levelEnd").play()
		transition()
