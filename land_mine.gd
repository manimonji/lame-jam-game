extends RigidBody3D

@export var explotion_power:= 1.0
@export var upward_force:= 1.0

func _on_body_entered(body):
	for overlapping_body in $ExplotionArea.get_overlapping_bodies():
		print_debug(overlapping_body)
		if overlapping_body is RigidBody3D:
			overlapping_body.follow_enabled = false
			overlapping_body.apply_impulse((overlapping_body.global_position - global_position + Vector3.UP * upward_force).normalized() * explotion_power, global_position)
	queue_free()
