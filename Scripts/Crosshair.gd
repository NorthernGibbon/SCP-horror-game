extends Control

@onready var crosshair: TextureRect = $TextureRect

func _process(_delta: float) -> void:
	if Global.hide_crosshair:
		crosshair.hide()
	elif not Global.hide_crosshair:
		crosshair.show()
