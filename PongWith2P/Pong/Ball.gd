extends KinematicBody2D

var speed := 600
var velocity := Vector2(1, 0.8)
var window_length := 1280
var window_width := 720
var game_over_state := false

func _ready():
	randomize()
	velocity.x = [1, -1][randi() % 2] 
	velocity.x = [0.8, -0.8][randi() % 2] 
	position = Vector2(window_length/2, window_width/2)

func _physics_process(delta):
	if not game_over_state:
		var collision_object
		collision_object = move_and_collide(velocity * speed * delta)
		if collision_object:
			velocity = velocity.bounce(collision_object.normal)
			if collision_object.collider == get_parent().get_node("Player") or collision_object.collider == get_parent().get_node("Opponent"):
				var sound_player := get_parent().get_node("BallHittingSound")
				sound_player.play()
				yield(get_tree().create_timer(0.1), "timeout")
				sound_player.stop()
		


func _on_Level_game_over():
	game_over_state = true
	yield(get_tree().create_timer(1), "timeout")
	randomize()
	velocity.x = [1, -1][randi() % 2] 
	velocity.x = [0.8, -0.8][randi() % 2] 
	position = Vector2(window_length/2, window_width/2)
	yield(get_tree().create_timer(1), "timeout")
	game_over_state = false
