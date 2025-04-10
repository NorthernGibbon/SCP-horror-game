extends Area3D

@onready var door_open: AudioStreamPlayer3D = $DoorOpen
@onready var door_close: AudioStreamPlayer3D = $DoorClose
@onready var animation: AnimationPlayer = $animation
@onready var door_locked: AudioStreamPlayer3D = $DoorLocked


var is_door_open = false
var player_has_keycard = false

func toggle(_body):
	is_door_open = not is_door_open
	
	if player_has_keycard and is_door_open and not animation.is_playing():
		animation.play("Door_open")
		door_open.play()
	elif player_has_keycard and not is_door_open and not animation.is_playing():
		animation.play("Door_close")
		door_close.play()
	elif not player_has_keycard:
		door_locked.play()
