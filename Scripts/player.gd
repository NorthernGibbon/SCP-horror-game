extends CharacterBody3D

const JUMP_VELOCITY = 4.5
var gravity = 9.8
var Sensitivity = 0.001

var direction = Vector3()

# Moving
var speed
const WALK_SPEED = 5.0
const SPRINT_SPEED = 8.0

# Bob
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var t_bob = 0.0

# Fov
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

#Objects
var picked_Object

# Inserts
@onready var head: Node3D = $Head
@onready var cam: Camera3D = $Head/cam
@onready var hold_object: Marker3D = %HoldObject

# Set Mouse mode and global player
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Global.register_player(self)

# Set head rotation
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Global.can_rotate:
		head.rotate_y(-event.relative.x * Sensitivity)
		cam.rotate_x(-event.relative.y * Sensitivity)
		cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-70), deg_to_rad(60))

# Set movement logic
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle Sprint
	if Input.is_action_pressed("sprint") and not Input.is_action_pressed("down"):
		speed = SPRINT_SPEED
		# FOV
		var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
		var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
		cam.fov = lerp(cam.fov, target_fov, delta * 8.0)
	else:
		speed = WALK_SPEED
		# FOV
		var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 0)
		var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
		cam.fov = lerp(cam.fov, target_fov, delta * 8.0)
	
	# Handle Lock movement when sitting
	if Global.is_sitting:
		speed = 0

	# Movement
	var input_dir := Input.get_vector("left", "right", "up", "down")
	direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 12.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 12.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)

	# Head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	cam.transform.origin = _headbob(t_bob)
	
	move_and_slide()

# Other inputs
func _input(event: InputEvent) -> void:
	# Handle pickup items
	if event.is_action_pressed("interact") and picked_Object:
		picked_Object.reparent(get_tree().current_scene)
		picked_Object = null

# Set player position 
func position():
	return self.position

# Headbob effect
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
