extends RigidBody3D

func _on_collection_area_body_entered(body):
	body.invinsible = true
	queue_free()
