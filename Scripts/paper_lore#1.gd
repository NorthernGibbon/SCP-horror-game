extends Node3D

@onready var lore_text_1: Node3D = $"."
@onready var lore_panel: Panel = $Panel
@onready var lore_text: Label = $Panel/Label
@onready var collision: CollisionShape3D = $Node/StaticBody3D/CollisionShape3D

var use_paper = false

func _ready() -> void:
	collision.disabled = true
	lore_text_1.hide()
	lore_panel.hide()

func _process(delta: float) -> void:
	if Global.paper_lore_1_collision:
		collision.disabled = false

func show_ui():
	# SCP Classified Document Format
	var lore_text_content = """
	████████████████████████████████████████████
		SCP FOUNDATION - INTERNAL TRANSCRIPT
		SECURITY CLEARANCE: LEVEL 4 REQUIRED
		PROJECT: [REDACTED]  
		DATE: [REDACTED]
		TRANSCRIPT LOG ID: 023-Theta
	████████████████████████████████████████████

		[BEGIN TRANSCRIPT]

		-- Dr. Lawrence: But we sent the Theta squad, did we not?

		-- Dr. Jensen: We did. None of them were recovered from [REDACTED].

		--  Dr. Mundo: Do we at least have the body cam footage?

		-- Dr. Jensen: Yes. It's being reviewed by Onslow and his team.

		-- Dr. Lawrence: Why? We should get first look at it. We are handling it after all.

		-- Dr. Jensen: Don't step out of line, Dr. Lawrence. Let them decide the next steps.

		-- Dr. Mundo: So what about us? We need that footage for our research.  
		-- How else are we supposed to contain it?

		-- Dr. Jensen: Right now, we just need to wait. I'm sure they'll be finished soon.

	████████████████████████████████████████████
		[END TRANSCRIPT]
	"""

	# Set the formatted lore text to the UI
	lore_text.text = lore_text_content

	# Show the panel with the SCP-styled document
	lore_panel.show()

func toggle(_body):
	
	use_paper = not use_paper
	
	if use_paper:
		Global.hide_crosshair = true
		Global.can_rotate = false
		Global.is_sitting = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		show_ui()  # Call show_ui() to display the SCP lore

	elif not use_paper:
		Global.hide_crosshair = false
		Global.can_rotate = true
		Global.is_sitting = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		lore_panel.hide()
