extends CharacterBody3D

var invinsible = false:
	set(value):
		invinsible = value
		if value:
			var tween = get_tree().create_tween()
			await get_tree().create_timer(5.0).timeout
			invinsible = false
			#tween.tween_property($MeshInstance3D.mesh, "mesh")
const SPEED = 5.0

@export var JUMP_VELOCITY = 6
@export var gravity: Vector3
@export var throw_power:= 1.0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_restart_area_body_entered(body):
	if invinsible:
		if body is RigidBody3D:
			body.follow_enabled = false
			body.apply_impulse((body.global_position - global_position).normalized() * throw_power, global_position)
	else:
		get_tree().reload_current_scene()
