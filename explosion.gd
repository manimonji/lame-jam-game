extends Node3D

@onready var debris: GPUParticles3D = $Debris
@onready var fire: GPUParticles3D = $Fire
@onready var smoke: GPUParticles3D = $Smoke

func explode():
	debris.emitting = true
	fire.emitting = true
	smoke.emitting = true
	await get_tree().create_timer(2).timeout
	call_deferred("queue_free")
