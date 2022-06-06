extends Label

func _process(_delta):
	if global.secretFound:
		text = "1"
	else:
		text = "0"
