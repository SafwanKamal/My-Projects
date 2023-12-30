extends KinematicBody2D

var y_speed := 600
var velocity := Vector2(0, 1)
var game_over_state := false

func _physics_process(delta):
	if not game_over_state:
		if Input.is_action_pressed("ui_up"):
			velocity.y = -1
			move_and_slide(velocity * y_speed)
		if Input.is_action_pressed("ui_down"):
			velocity.y = 1
			move_and_slide(velocity * y_speed)
		
		


func _on_Level_game_over():
	position = Vector2(1250, 360)
	game_over_state = true
	yield(get_tree().create_timer(2), "timeout")
	game_over_state = false
