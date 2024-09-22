class_name ExplosionArea
extends Area3D

@export var explosion_power:= 1.0

func explode():
	for overlapping_body in get_overlapping_bodies():
		print_debug(overlapping_body)
		if overlapping_body is RigidBody3D:
			overlapping_body.apply_impulse((overlapping_body.position - position) * explosion_power)
