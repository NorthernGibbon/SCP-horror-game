extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		Global.is_in_lab = true

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		Global.is_in_lab = true
