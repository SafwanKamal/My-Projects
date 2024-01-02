extends Node2D

#@onready var Utils = preload("res://scripts/utils.gd")

@export var Explosion:PackedScene
@export var game_over_scene:PackedScene

var score:int = 0

@onready var screen_rect = get_viewport_rect()

func _on_player_hit(): 
	explode($Player.global_position)
	$Player.queue_free()
	var game_over = game_over_scene.instantiate()
	game_over.position = Vector2(screen_rect.size.x/2,screen_rect.size.y/2)
	game_over.show_score(score)
	add_child(game_over)

func explode(pos:Vector2):
	var explosion = Explosion.instantiate()
	explosion.position = pos
	add_child(explosion)


func _on_asteroid_hit():
	score+=1

