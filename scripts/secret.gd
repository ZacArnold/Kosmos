extends Area

func _ready():
	visible = false

func _on_secret_body_entered(body):
	if body.name == "player":
		$pickupConfirm.play()
		$meshInstance.visible = false
		$directionalLight.light_energy = 0
		global.secretFound = true

func _on_levelStart_body_entered(body):
	if body.name == "player":
		visible = true

func _process(_delta):
	rotate_x(deg2rad(2))
	rotate_y(deg2rad(3))
	rotate_z(deg2rad(1))

func _on_pickupConfirm_finished():
	queue_free()


func _on_controlOn_body_entered(body):
	if body.name == "player":
		visible = true
