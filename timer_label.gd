extends Label

@onready var start_time = Time.get_ticks_usec()

func _process(delta):
	text = str(floor((Time.get_ticks_usec() - start_time) / 100000.0) / 10)
