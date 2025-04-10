extends Area3D

@onready var door_open: AudioStreamPlayer3D = $DoorOpen
@onready var door_close: AudioStreamPlayer3D = $DoorClose
@onready var animation: AnimationPlayer = $animation


var is_door_open = false

func toggle(_body):
	is_door_open = not is_door_open
	
	if is_door_open and not animation.is_playing():
		animation.play("Door_open")
		door_open.play()
	elif not is_door_open and not animation.is_playing():
		animation.play("Door_close")
		door_close.play()
		
