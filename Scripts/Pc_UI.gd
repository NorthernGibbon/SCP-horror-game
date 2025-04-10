extends Node3D

@onready var panel: Panel = $Panel
@onready var user_input: LineEdit = $Panel/UserInput
@onready var submit: Button = $Panel/Submit
@onready var feedback: Label = $Panel/Feedback
@onready var attempts_label: Label = $Panel/AttemptsLabel
@onready var cooldown_timer: Timer = $Cooldown

var use_pc := false

var target_frequency = 0
var attempts = 0
var max_attempts = 10
var current_attempts
var window_is_showing
var can_start_new_task := true 

func _ready() -> void:
	panel.hide()
	Global.register_computer(self)
	
	if not cooldown_timer.timeout.is_connected(self._on_success_cooldown_timeout):
		cooldown_timer.timeout.connect(self._on_success_cooldown_timeout)
	
	cooldown_timer.wait_time = 5.0  
	cooldown_timer.one_shot = true

func toggle(_body):
	use_pc = not use_pc
	
	if use_pc:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Global.hide_crosshair = true
		Global.can_rotate = false
		Global.is_sitting = true
		
		if can_start_new_task:
			target_frequency = randi() % 100 + 1
			attempts = 0

			feedback.text = "Begin Frequency Calibration"
			user_input.text = ""
			user_input.editable = true  
			submit.disabled = false     
		else:
			feedback.text = "System recalibrating... Please wait..."
			user_input.editable = true  
			submit.disabled = false      

		panel.show()
	else:
		close_pc()

func submit_guess():
	if not can_start_new_task:
		feedback.text = "No new calibrations available. Please wait..."
		return  

	current_attempts = max_attempts - attempts
	Global.hide_crosshair = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	var guess = user_input.text.to_int()
	attempts_label.text = str(target_frequency)
	window_is_showing = true
	attempts += 1

	if guess == target_frequency:
		feedback.text = "Correct! Frequency aligned."
		Global.increase_Frequency_counter()
		
		start_success_cooldown()  
		on_alignment_success()
		finish_task()  
	elif attempts >= max_attempts:
		feedback.text = "Too many attempts! Try again later."
		finish_task() 
	else:
		if guess < target_frequency:
			feedback.text = "Too Low! Try again."
		else:
			feedback.text = "Too High! Try again."

func finish_task() -> void:
	await get_tree().create_timer(1.5).timeout
	close_pc()

func start_success_cooldown():
	can_start_new_task = false  
	cooldown_timer.start()
	feedback.text = "System recalibrating... Please wait..."

func _on_success_cooldown_timeout():
	can_start_new_task = true  
	feedback.text = "System ready. You may start a new task."

func close_pc():
	use_pc = false
	panel.hide()
	Global.hide_crosshair = false
	Global.can_rotate = true
	Global.is_sitting = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func on_alignment_success():
	print("Frequency alignment completed.")
	# Add any additional logic (e.g. SCP whispers or visual effects) here.

# Allow the player to cancel the interaction at any time by pressing ESC (or ui_cancel)
func _input(event):
	if event.is_action_pressed("ui_cancel") and use_pc:
		close_pc()
