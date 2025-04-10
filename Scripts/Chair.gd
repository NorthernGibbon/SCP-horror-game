extends Node3D

@onready var chair: Node3D = $"."
@onready var collision: CollisionShape3D = $Node/Chair/StaticBody3D/CollisionShape3D
@onready var collision2: CollisionShape3D = $Node/Chair/StaticBody3D/CollisionShape3D2
@onready var chair_body: StaticBody3D = $Node/Chair/StaticBody3D

var Is_Sitting

func _ready() -> void:
	pass

func toggle(_body):
	# När toggle är activerat så ska vi låsa spelarens position på stolen till man klickar E igen
	if not Is_Sitting and Input.is_action_just_pressed("interact"):
		Global.player.position = chair.position
		Global.is_sitting = true
		Is_Sitting = true
		chair_body.collision_layer = 2
		chair_body.collision_mask = 2
	elif Input.is_action_just_pressed("interact") and Is_Sitting:
		Global.is_sitting = false
		Is_Sitting = false
		chair_body.collision_layer = 1
		chair_body.collision_mask = 1
