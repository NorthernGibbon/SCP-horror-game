extends Node3D

@onready var light: OmniLight3D = $Node/OmniLight3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready() -> void:
	Global.light_energy_value = 1

func _process(_delta: float) -> void:
	light.light_energy = Global.light_energy_value
