extends RayCast3D

@onready var prompt: Label = $prompt


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	prompt.text = ""
	
	if is_colliding():
		var collider = get_collider()
		
		if collider is Interactable:
			prompt.text = collider.get_prompt()
			
			if Input.is_action_just_pressed(collider.promp_input):
				collider.interact(owner)
