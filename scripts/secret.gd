extends Area

onready var global = get_node("/root/Global")

func _ready():
	$meshInstance.visible = false

func _on_secret_body_entered(body):
	if body.name == "player":
		queue_free()
		global.secretsFound += 1

func _on_levelStart_body_entered(body):
	if body.name == "player":
		$meshInstance.visible = true
