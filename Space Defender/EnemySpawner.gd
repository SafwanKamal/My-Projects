extends Node2D


onready var spawnPoints := $SpawnPoins.get_children()

var Enemy1 = preload("res://Enemy1.tscn")

func _ready():
	randomize()

func get_enemy_spawn_position():
	return spawnPoints[randi() %  spawnPoints.size()].global_position

func add_enemy():
	var enemy = Enemy1.instance()
	enemy.global_position = get_enemy_spawn_position()
	get_tree().current_scene.add_child(enemy)

func _on_EnemySpawnTimer_timeout():
	add_enemy()
	
