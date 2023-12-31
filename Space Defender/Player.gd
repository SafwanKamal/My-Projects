extends Node2D

const MOVE_SPEED := 300
const ACCELERATION := 2000
const FRICTION := 3000
const WINDOW_LENGTH := 300
const WINDOW_WIDTH := 180
const PLAYER_WIDTH := 11

var velocity := Vector2.ZERO
var can_fire := true
export var player_health := 5

onready var Gun := $Gun1

signal Game_over

func _ready():
	Gun.laser_velocity = Vector2(600, 0)
	Gun.laser_offset = 10


func _process(delta):
	if player_health <= 0:
		game_over()
	
	move_player(take_movement_input(), delta)
	
	if Input.is_action_pressed("ui_space"):
		Gun.shoot_laser()
		Gun.will_play_sound = true
	
func take_movement_input():
	var input_velocity := Vector2.ZERO
	
	Gun.global_position.x = global_position.x + 10
	
	input_velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	input_velocity = input_velocity.normalized()
	
	return input_velocity
	


func move_player(input_velocity, delta):
	#Remember to multiply MOVE_SPEED to input_velocity, otherwise
	
	if input_velocity == Vector2.ZERO:
		velocity = velocity.move_toward(input_velocity * MOVE_SPEED, FRICTION * delta)
	else:
		velocity = velocity.move_toward(input_velocity * MOVE_SPEED, ACCELERATION * delta)
	
	global_position += velocity * delta
	
	
	if global_position.x > WINDOW_LENGTH - PLAYER_WIDTH:
		global_position.x = WINDOW_LENGTH - PLAYER_WIDTH
	elif global_position.x < 0 + PLAYER_WIDTH:
		global_position.x =  0 + PLAYER_WIDTH
		
	
	if global_position.y > WINDOW_WIDTH - PLAYER_WIDTH:
		global_position.y = WINDOW_WIDTH - PLAYER_WIDTH
	elif global_position.y < 0 + PLAYER_WIDTH:
		global_position.y =  0 + PLAYER_WIDTH
	


func _on_Area2D_area_entered(area):
	if area.is_in_group("Laser"):
		player_health -= 1
	else:
		game_over()
		
func game_over():
	emit_signal("Game_over")
