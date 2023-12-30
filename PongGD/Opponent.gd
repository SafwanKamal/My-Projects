extends KinematicBody2D


var speed = 400
var ball

func _ready():
	ball = get_parent().find_node("Ball") 

func _physics_process(delta):
	
	var velocity = Vector2.ZERO
	
	#if Input.is_action_pressed("w"):
	#	velocity.y -= 1
	#elif Input.is_action_pressed("s"):
	#	velocity.y += 1
	
	#position.y = ball.position.y
	
	velocity.y += get_opponent_direction()
		
	move_and_slide(velocity * speed)

func get_opponent_direction():
	if abs(position.y - ball.position.y) > 30:
		if position.y > ball.position.y: return -1
		else: return 1
	else: return 0
