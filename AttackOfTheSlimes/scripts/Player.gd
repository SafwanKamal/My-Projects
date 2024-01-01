extends CharacterBody2D

signal dead(pos:Vector2)

@export var tank_scene_preset:PackedScene
@export var acceleration:int = 130
@export var max_speed:int = 350
@export var friction:int = 3
@export var rotation_speed:int = 3
@export var missile_scene:PackedScene

var max_health := 400

var health := max_health:
	set(value):
		var new_health = min(max_health,max(0,value))
		if new_health<health:
			pass #run animation
		health = new_health
		if health == 0:
			dead.emit(global_position)
			gun_pivot.get_parent().hide()
			velocity = Vector2.ZERO
			acceleration = 0
			rotation_speed = 0
			$Explosion.show()
			$Camera2D.shake(0.7,1)
			$Explosion.play("fire")

var input_vec:Vector2
var gun_pivot:Node2D
var projectile_type:int

func _ready():
	var tank_preset = tank_scene_preset.instantiate()
	var set = tank_preset.get_preset(2)
	gun_pivot = set.preset.find_child("GunPivot")
	add_child(set.preset)
	add_child(set.collision_shape)
	projectile_type = $ProjectileLauncher.type.BULLET

func _process(delta):
	input_vec.x = Input.get_axis("rotate_left","rotate_right")
	input_vec.y = Input.get_axis("forward","backward")
	if Input.is_action_pressed("select_bullet"):
		projectile_type = $ProjectileLauncher.type.BULLET
	elif Input.is_action_pressed("select_missile"):
		projectile_type = $ProjectileLauncher.type.MISSILE
	elif Input.is_action_pressed("select_morter"):
		projectile_type = $ProjectileLauncher.type.MORTER
	if Input.is_action_pressed("shoot"):
		$ProjectileLauncher.shoot(projectile_type)


func _physics_process(delta):
	rotation = lerp(rotation,rotation+input_vec.x,rotation_speed*delta)
	if input_vec.y != 0 :
		velocity = Vector2(input_vec.y,0).rotated(rotation+PI/2) * acceleration
		velocity = velocity.limit_length(max_speed)
	elif input_vec.y == 0 and velocity != Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO,friction)
		if velocity.length() < 0.1:
			velocity = Vector2.ZERO
	
	gun_pivot.look_at(get_global_mouse_position())
	move_and_collide(velocity * delta)


func _on_explosion_animation_finished():
	queue_free()


func _on_projectile_launcher_shot(type):
	if type == $ProjectileLauncher.type.MISSILE:
		$Camera2D.shake(1,0.5)
