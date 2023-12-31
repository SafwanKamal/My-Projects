extends Node2D


@export var slime_scene:PackedScene

var markers:Array = []

func _ready():
	get_parent().find_child("Player").tree_exited.connect(_on_player_tree_exited)
	for child in get_children():
		if "Marker" in child.name:
			markers.push_back(child)
	#print(markers)

func _on_timer_timeout():
	var random_marker = markers.pick_random()
	var spawn_location = random_marker.global_position
	var slime = slime_scene.instantiate()
	slime.global_position = spawn_location
	get_tree().root.add_child(slime)

func _on_player_tree_exited():
	$Timer.stop()
