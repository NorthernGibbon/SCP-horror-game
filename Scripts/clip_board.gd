extends Node3D

@onready var frequency_counter: Label = $Panel/FrequencyCounter
@onready var panel: Panel = $Panel

var use_clipboard = false

func _ready() -> void:
	update_ui()
	Global.connect("frequency_updated", Callable(self, "_on_frequency_updated"))
	panel.hide()

func update_ui():
	frequency_counter.text = str(Global.FrequencyAlignmentCounter)

func _on_frequency_updated(new_value):
	frequency_counter.text = "Tasks Completed: " + str(new_value)

func toggle(_body):
	use_clipboard = not use_clipboard
	
	if use_clipboard:
		Global.hide_crosshair = true
		Global.can_rotate = false
		Global.is_sitting = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		panel.show()
		
	elif not use_clipboard:
		Global.hide_crosshair = false
		Global.can_rotate = true
		Global.is_sitting = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		panel.hide()
