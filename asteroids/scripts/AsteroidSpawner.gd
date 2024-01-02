extends Node2D

@export var asteroid_scene:PackedScene
@export var invincible_power_scene:PackedScene
@export var max_count = 10

@onready var spawn_locations = [$Marker2D,$Marker2D2,$Marker2D3,$Marker2D4]

@onready var Util = preload("res://scripts/utils.gd")

var count:int = 0

func _on_spawn_timer_timeout():
	if count >= max_count:
		return
	var spawn_location = spawn_locations.pick_random()
	spawn_asteroid(Util.AsteroidSize.BIG,spawn_location.global_position)
	count+=1

func _spawn_smaller_asteroids(size:int,pos:Vector2):
	if size == 2:
		var power = invincible_power_scene.instantiate()
		power.position = Vector2(pos.x + randi_range(-10,10),pos.y + randi_range(-10,10))
		get_tree().root.get_child(0).add_child(power)
		return
	
	if randi_range(-1,1)>0:
		var power = invincible_power_scene.instantiate()
		power.position = Vector2(pos.x + randi_range(-10,10),pos.y + randi_range(-10,10))
		get_tree().root.get_child(0).add_child(power)
	
	for i in range(2):
		spawn_asteroid(min(size+1,2),pos)

func spawn_asteroid(size:int,pos:Vector2):
	var asteroid = asteroid_scene.instantiate()
	asteroid.position = pos
	asteroid.size = size
	asteroid.player_hit.connect(Callable(get_tree().root.get_child(0),"_on_player_hit"))
	asteroid.asteroid_hit.connect(Callable(get_tree().root.get_child(0),"_on_asteroid_hit"))
	asteroid._spawn_smaller_asteroids.connect(_spawn_smaller_asteroids)
	get_tree().root.get_child(0).add_child(asteroid)
