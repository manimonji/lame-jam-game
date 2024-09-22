extends Node

@onready var restart_layer = $"../RestartLayer"

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().paused = false
		get_tree().reload_current_scene()


func _on_player_died():
	restart_layer.visible = true
