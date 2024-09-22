class_name GravityComponent
extends Node

@export var gravity: Vector3
@export var velocity_component: VelocityComponent
var accelaration:= 1.0

func _process(delta):
	if get_parent().is_on_floor():
		accelaration = 0
	else:
		#await get_tree().create_timer(3).timeout
		accelaration += 3.0
		get_parent().velocity += gravity * delta * accelaration
		get_parent().move_and_slide()
	
