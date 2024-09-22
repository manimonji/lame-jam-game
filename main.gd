extends Node

@onready var path_follow_3d = $Path3D/PathFollow3D

@export var mine_scene: PackedScene
@export var enemy_scene: PackedScene
@export var mine_spawn_randomness: float

func _on_enemy_spawn_timer_timeout():
	path_follow_3d.progress_ratio = randf()
	var enemy = enemy_scene.instantiate()
	enemy.position = path_follow_3d.position 
	enemy.target = $Player
	get_tree().current_scene.add_child(enemy)
	#for child in enemy.get_children():
		#if child is FollowerMovementComponent:
			#child.target = $Player


func _on_mine_spawn_timer_timeout():
	var mine:Node3D = mine_scene.instantiate()
	var offset = Vector3(
		randf_range(-mine_spawn_randomness, mine_spawn_randomness),
		0,
		randf_range(-mine_spawn_randomness, mine_spawn_randomness),
	)
	mine.position = $MineSpawnBaseMarker.position + offset
	get_tree().current_scene.add_child(mine)
