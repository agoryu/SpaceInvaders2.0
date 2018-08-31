extends KinematicBody2D

export (int) var speed = 50

# State of column
var RIGHT_STATE = "right"
var LEFT_STATE = "left"
var current_state = null

func _ready():
	current_state = RIGHT_STATE
	for group in get_children():
		group.connect("out_area", self, "_on_invader_out_area")

func _process(delta):
	if current_state == RIGHT_STATE:
		move_and_slide(Vector2(speed, 0))
	else:
		move_and_slide(Vector2(-speed, 0))
	if get_child_count() < 1:
		get_node("/root/Game").win()


func _on_invader_out_area():
	if current_state == RIGHT_STATE:
		current_state = LEFT_STATE
	else:
		current_state = RIGHT_STATE
	move_local_y(20)
