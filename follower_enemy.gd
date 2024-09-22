extends RigidBody3D



@export var target: Node3D
var speed: float = 30
var follow_enabled = true

@onready var destroy_timer: Timer = $DestroyTimer
@onready var dust: GPUParticles3D = $Dust
@onready var mow_audio = $MowAudio

func look_follow(state: PhysicsDirectBodyState3D, current_transform: Transform3D, target_position: Vector3) -> void:
	var forward_local_axis: Vector3 = Vector3(1, 0, 0)
	var forward_dir: Vector3 = (current_transform.basis * forward_local_axis).normalized()
	var target_dir: Vector3 = (target_position - current_transform.origin).normalized()
	var local_speed: float = clampf(speed, 0, acos(forward_dir.dot(target_dir)))
	if forward_dir.dot(target_dir) > 1e-4:
		state.angular_velocity = local_speed * forward_dir.cross(target_dir) / state.step		

func _process(delta: float) -> void:
	dust.emitting = linear_velocity.length() > 5 and get_contact_count() > 0

func _integrate_forces(state):
	var desired_direction= (target.global_position - global_position).normalized()
	desired_direction.y = 0
	destroy_timer.start()
	if get_contact_count() > 0:
		look_follow(state, global_transform, global_position + desired_direction)
		apply_force(desired_direction * speed)
		destroy_timer.stop()

func die():
	mow_audio.play()

func _on_destroy_timer_timeout() -> void:
	queue_free()
