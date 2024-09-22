extends Node3D

@onready var explosion_sound: AudioStreamPlayer3D = $ExplosionSound

func play():
	explosion_sound.play()
	await get_tree().create_timer(5).timeout
	queue_free()
