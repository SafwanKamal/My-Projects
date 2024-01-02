extends CharacterBody2D

@export var max_speed = 10
@export var rotation_speed = 3.5
@export var velocity_damping = 5
@export var linear_acceleration = 300

@export var missile_scene:PackedScene

@onready var engine_sound = $EngineSound

var is_invincible := false
var input_vec:Vector2
var radius = 5
var rotation_direction:int 

func _process(delta):
	input_vec.x = Input.get_action_strength("rotate_left")-Input.get_action_strength("rotate_right")
	input_vec.y = Input.get_action_strength("thrust")
	
	if Input.is_action_pressed("thrust"):
		$EngineThrottle.show()
		engine_sound.play()
	elif Input.is_action_just_released("thrust"):
		$EngineThrottle.hide()
		engine_sound.stop()
	
	if Input.is_action_pressed("rotate_left"):
		rotation_direction = -1
	elif Input.is_action_pressed("rotate_right"):
		rotation_direction = 1
	else:
		rotation_direction = 0
		
	if Input.is_action_pressed("shoot"):
		$BulletLauncher.shoot()
	if Input.is_action_pressed("shoot_missile") and $MissileCooldownTimer.is_stopped():
		var missile = missile_scene.instantiate()
		missile.launch($BulletLauncher.global_position,Vector2.from_angle(rotation+PI/2),rotation)
		get_tree().root.get_child(0).add_child(missile)
		$MissileCooldownTimer.start()
		
	
func _physics_process(delta):
	rotation += rotation_direction * rotation_speed * delta
	if input_vec.y>0:
		velocity += (input_vec * linear_acceleration * delta).rotated(rotation)
		velocity.limit_length(max_speed)
	elif input_vec.y == 0 and velocity != Vector2.ZERO:
		velocity = lerp(velocity,Vector2.ZERO,velocity_damping * delta)
		var speed = velocity.length()
		if speed < 0.1:
			velocity = Vector2.ZERO
	
	move_and_collide(velocity * delta)

func _on_power_timeup():
	is_invincible = false
	$InvincibleCircle.hide()
