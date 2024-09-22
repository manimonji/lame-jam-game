class_name VelocityComponent
extends Node

var velocity:= Vector3.ZERO


func _physics_process(delta):
	(get_parent() as CharacterBody3D).velocity = velocity
	(get_parent() as CharacterBody3D).move_and_slide()
