extends Area

onready var global = get_node("/root/Global")

func _on_secret_body_entered(body):
	if body.name == "player":
		queue_free()
		global.secretFound = true

func _on_levelStart_body_entered(body):
	if body.name == "player":
		visible = true

func _process(_delta):
	rotate_x(deg2rad(2))
	rotate_y(deg2rad(3))
