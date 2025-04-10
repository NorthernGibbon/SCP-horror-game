extends Node3D

@onready var animation: AnimationPlayer = $"../../AnimationPlayer"
var Light_switch := true
var light_on := false

func toggle_light(_body):
	light_on = not light_on
	Light_switch = not Light_switch
	
	if light_on and not animation.is_playing():
		Global.light_energy_value = 0;
		animation.play("lever_activate")
	elif not light_on and not animation.is_playing():
		Global.light_energy_value = 1;
		animation.play("lever_deactivate")
