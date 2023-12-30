extends KinematicBody2D

export var speed = 400

func _physics_process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed 
	elif Input.is_action_pressed("ui_down"):
		velocity.y += speed 
	#elif Input.is_action_pressed("ui_left"):
	#	velocity.x -= speed
	#elif Input.is_action_pressed("ui_right"):
	#	velocity.x += speed
	
		
	move_and_slide(velocity)
	
