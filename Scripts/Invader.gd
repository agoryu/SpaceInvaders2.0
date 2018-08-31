extends KinematicBody2D

# Shoot
onready var bullet_scene = preload("res://Scenes/BulletInvader.tscn")
export (int) var bullet_frequency = 5
var bullet_delay = 100
var raycast_down = null

func _ready():
	raycast_down = $RayCast
	$InvaderArea/AnimatedSprite.play()

func _process(delta):
	var colliding = raycast_down.is_colliding()
	var world_position = self.get_global_transform().get_origin()
	
	if !colliding:
		var shoot = randi() % 1000 + 1
		if shoot < bullet_frequency and bullet_delay == 0:
			var bullet = bullet_scene.instance()
			# Position dans le world legerement en dessous de l'invader
			bullet.position = world_position
			bullet.position.y += 60
			# Gestion du temps de recharge
			bullet_delay = 100
			get_node("/root").add_child(bullet)
		elif bullet_delay > 0:
			bullet_delay -= 1

func _on_InvaderArea_body_entered(body):
	if body.get("name").begins_with("Bullet"):
		get_node("/root/Game").update_score(100)
		get_node("/root/Game/Camera").shake(0.5, 10, 10)
		body.queue_free()
		get_parent().queue_free()
