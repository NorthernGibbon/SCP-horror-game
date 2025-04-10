extends StaticBody3D

@onready var animation: AnimationPlayer = $"../../AnimationPlayer"
@onready var light: DirectionalLight3D = $"../DirectionalLight3D"


var is_door_open = false

func toggle_light(_body):
	is_door_open = not is_door_open
	
	if is_door_open and not animation.is_playing():
		animation.play("lever_activate")
		light.light_energy = 10
		#door_open.play()
	elif not is_door_open and not animation.is_playing():
		animation.play("lever_deactivate")
		light.light_energy = 0
		#door_close.play()
		
