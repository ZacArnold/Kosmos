extends Label

onready var global = get_node("/root/Global")

func _process(_delta):
	if global.secretFound:
		text += str(1)
	else:
		text = str(0)
