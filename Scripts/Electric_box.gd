extends Node3D

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var electric_open: AudioStreamPlayer3D = $Electric_open
@onready var electric_close: AudioStreamPlayer3D = $Electric_close


var is_door_open = false

func toggle(_body):
	is_door_open = not is_door_open
	
	if is_door_open and not animation.is_playing():
		animation.play("open_lid")
		electric_open.play()
	elif not is_door_open and not animation.is_playing():
		animation.play("close_lid")
		electric_close.play()
