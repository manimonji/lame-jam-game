extends RigidBody3D

@export var explotion_power:= 1.0
@export var upward_force:= 1.0
@export var explosion_scene: PackedScene
@export var explosion_sound_scene: PackedScene

var exploding = false

func explode():
	exploding = true
	var explosion = explosion_scene.instantiate()
	var explosion_sound = explosion_sound_scene.instantiate()
	get_tree().current_scene.add_child(explosion)
	get_tree().current_scene.add_child(explosion_sound)
	explosion.global_position = global_position
	explosion_sound.global_position = global_position
	explosion.explode()
	explosion_sound.play()
	for overlapping_body in $ExplotionArea.get_overlapping_bodies():
		print_debug(overlapping_body)
		if overlapping_body is RigidBody3D:
			if overlapping_body.get_groups().has("mines") and not overlapping_body.exploding:
				overlapping_body.explode()
			if overlapping_body.get_groups().has("enemies"):
				overlapping_body.die()
				overlapping_body.apply_impulse((overlapping_body.global_position - global_position + Vector3.UP * upward_force).normalized() * explotion_power, global_position)
	queue_free()
func _on_body_entered(body):
	explode()
