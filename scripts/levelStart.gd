extends Area

onready var global = get_node("/root/Global")

func _on_animationPlayer_animation_finished(_anim_name):
		global.controlAllowed = true

