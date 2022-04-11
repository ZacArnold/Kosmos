extends Area

onready var global = get_node("/root/Global")

func _on_secret_body_entered(body):
	if body.name == "player":
		queue_free()
		global.secretsFound += 1
