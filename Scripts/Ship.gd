extends KinematicBody2D

var screensize  # Size of the game window.

#Ship
export (int) var speed

#Fire
onready var bullet_scene = preload("res://Scenes/Bullet.tscn")
var bullet_delay = 0

func _ready():
	screensize = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2() # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_accept"):
		shooting()
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position.x = clamp(position.x, 32, screensize.x - 32)
	
	#Bullet
	if bullet_delay > 0:
		bullet_delay -= 1
	
func shooting():
	if bullet_delay == 0:
		var bullet = bullet_scene.instance()
		bullet.position = position
		bullet.position.y -= 50
		get_parent().add_child(bullet)
		bullet_delay = 40
		$Shoot.play()

func _on_Area2D_body_entered(body):
	if !body.get("name").begins_with("Invader"):
		get_node("/root/Game").loose_life()
		body.queue_free()
	else:
		get_node("/root/Game").game_over()
