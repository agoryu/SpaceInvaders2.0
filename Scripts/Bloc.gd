extends Area2D

func _on_Bloc_body_entered(body):
	queue_free()
	if !body.get("name").begins_with("Invader"):
		body.queue_free()
