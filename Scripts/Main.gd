extends Node2D

var score = 0
var current_scene

# Camera shake


onready var stage1 = preload("res://Scenes/Stage1.tscn")

func _ready():
	$HUD/Score.text = str(score)
	pass

func update_score(point):
	score += point
	$HUD/Score.text = str(score)
	
func loose_life():
	var lives = $HUD/Lives
	var children_count = lives.get_child_count()
	if children_count < 1:
		game_over()
	else:
		lives.get_children().pop_back().queue_free()
		$ColorRect.color = Color(255, 0, 0)
		$ImpactTimer.start()
		

func display_interface():
	$HUD/ScoreLabel.show()
	$HUD/Score.show()
	$HUD/LivesLabel.show()
	$HUD/Lives.show()

func hide_interface():
	$HUD/ScoreLabel.hide()
	$HUD/Score.hide()
	$HUD/LivesLabel.hide()
	$HUD/Lives.hide()
	
func show_message(text):
	$HUD/Message.text = text
	$HUD/Message.show()
	$MessageTimer.start()
	
func game_over():
	current_scene.queue_free()
	hide_interface()
	show_message("GAME OVER")
	yield($MessageTimer, "timeout")
	$HUD/Start.show()
	$HUD/Title.show()

func win():
	current_scene.queue_free()
	hide_interface()
	show_message("CONGRATULATION")
	yield($MessageTimer, "timeout")
	show_message("THANKS FOR PLAYING")
	yield($MessageTimer, "timeout")
	$HUD/Start.show()
	$HUD/Title.show()

func _on_Start_pressed():
	$HUD/Start.hide()
	$HUD/Title.hide()
	display_interface()
	show_message("READY PLAYER ONE")
	yield($MessageTimer, "timeout")
	current_scene = stage1.instance()
	add_child(current_scene)
	print(current_scene)

func _on_MessageTimer_timeout():
	$HUD/Message.hide()

func _on_ImpactTimer_timeout():
	$ColorRect.color = Color(0, 0, 0)
