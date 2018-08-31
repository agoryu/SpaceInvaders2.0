extends Node2D

export (int) var speed = 200

func _ready():
	pass

func _process(delta):
	if position.y < 0:
		queue_free()
	position.y -= delta * speed
