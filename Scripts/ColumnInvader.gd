extends Node2D

signal out_area

# Screen
var SCREEN_MIN = 0
var SCREEN_MAX = 1024

# Calculate movement
export (int) var offset_screen = 25

func _process(delta):
	var world_position = self.get_global_transform().get_origin()
	if world_position.x + offset_screen > SCREEN_MAX or world_position.x - offset_screen < SCREEN_MIN:
		emit_signal("out_area")
	if get_children().size() < 1:
		queue_free()
