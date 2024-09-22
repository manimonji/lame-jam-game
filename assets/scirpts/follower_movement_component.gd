class_name FollowerMovementComponent
extends RigidBody3D


@export var target: Node3D

@onready var parent = get_parent() as RigidBody3D
#@export var speed: Vector3
#@export var velocity_component: VelocityComponent
#@export var steering_amount: float
#
#func _physics_process(delta):
	#if get_parent().is_on_floor():
		#var old_velocity = (velocity_component.velocity).normalized()
		#var wanted_velocity = (target.global_position - (get_parent() as Node3D).global_position).normalized()
		#var velocity = speed * ((wanted_velocity + old_velocity * steering_amount) / 2).normalized()
		#get_parent().look_at(get_parent().position + velocity)
		#get_parent().rotation.x = 0
		#velocity_component.velocity.x = 0
		#velocity_component.velocity.z = 0
		#velocity_component.velocity += velocity

func look_follow(state: PhysicsDirectBodyState3D, current_transform: Transform3D, target_position: Vector3) -> void:
	var forward_local_axis: Vector3 = Vector3(1, 0, 0)
	var forward_dir: Vector3 = (current_transform.basis * forward_local_axis).normalized()
	var target_dir: Vector3 = (target_position - current_transform.origin).normalized()
	var local_speed: float = clampf(speed, 0, acos(forward_dir.dot(target_dir)))
	if forward_dir.dot(target_dir) > 1e-4:
		state.angular_velocity = local_speed * forward_dir.cross(target_dir) / state.step
		
var speed: float = 0.1

func _integrate_forces(state):
	look_follow(state, parent.global_transform, target.global_position)
	
