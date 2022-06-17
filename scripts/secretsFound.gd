extends Label

func _ready():
	$cleanMetalSecret.visible = false
	$redSecret.visible = false
	$greenSecret.visible = false
	$goldSecret.visible = false
	$blueSecret.visible = false

func _process(_delta):
	if global.cleanMetalSecret == true:
		$cleanMetalSecret.visible = true
	if global.redSecret == true:
		$redSecret.visible = true
	if global.greenSecret == true:
		$greenSecret.visible = true
	if global.goldSecret == true:
		$goldSecret.visible = true
	if global.blueSecret == true:
		$blueSecret.visible = true
