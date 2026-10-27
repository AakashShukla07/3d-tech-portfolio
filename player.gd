extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var mouse_sensitivity = 0.002

# Get the gravity from the project settings
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# This links the script to your Camera3D node
@onready var camera = $Camera3D

func _ready():
	# Hide the mouse cursor and lock it to the game window when you start
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	# Listen for mouse movement
	if event is InputEventMouseMotion:
		# Look left/right (rotates the whole body)
		rotate_y(-event.relative.x * mouse_sensitivity)
		# Look up/down (rotates only the camera)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		# Stop the camera from flipping upside down
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(delta):
	# Add gravity if you are in the air
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump (Spacebar by default)
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle WASD / Arrow Key movement
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	# Press 'Escape' to unlock your mouse so you can close the game tab
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
