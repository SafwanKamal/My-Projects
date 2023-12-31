extends CharacterBody2D

@export var max_speed = 80
@export var damage = 5

var speed:int
var player:CharacterBody2D
var in_contact_with_player:bool
var direction:Vector2

signal enemy_dead(pos:Vector2)

func _ready():
	speed = max_speed
	player = get_tree().root.get_child(0).find_child("Player")
	player.tree_exited.connect(_on_player_tree_exited)
	

func _process(delta):
	if player:
		direction =  (player.global_position - global_position).normalized()
		if direction.x<0 and not $AnimatedSprite2D.flip_h:
			$AnimatedSprite2D.flip_h = true
		elif direction.x>0 and $AnimatedSprite2D.flip_h:
			$AnimatedSprite2D.flip_h = false
		
		if in_contact_with_player:
			player.health -= damage

func _physics_process(delta):
	move_and_collide(direction * speed * delta)
	
func _on_player_tree_exited():
	player = null

func _on_body_entered(body):
	in_contact_with_player = true
	$AnimatedSprite2D.play("dealing_damage")
	speed = 0


func _on_body_exited(body):
	in_contact_with_player = false
	speed = max_speed
	$AnimatedSprite2D.play("default")


func _on_area_entered(area):
	enemy_dead.emit(global_position)
	queue_free()

