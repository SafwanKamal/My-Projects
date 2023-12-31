extends Node2D

export var MOVE_SPEED := 100
export var ARMOR := 3

var Explosion = preload("res://Explosion.tscn")

onready var sprite = $Sprite
onready var gun1 = $Gun1

func _ready():
	gun1.laser_velocity = Vector2(-500, 0)
	gun1.laser_rotation_degrees = 180


var damage_color := {
	2 : Color(0.71, 0.56, 0.56),
	1 : Color(0.47, 0.30, 0.30)
}

func _process(delta):
	global_position += MOVE_SPEED * Vector2(-1, 0) * delta



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



func _on_Area2D_area_entered(_area):
	ARMOR -= 1
		
	if ARMOR <= 0:
		death()
		return 
		
	damage_taken(ARMOR)
		
func damage_taken(ARMOR):
	sprite.self_modulate = damage_color[ARMOR]
		

func death():
	queue_free()
	explosion()
	

func explosion():
	var explosion = Explosion.instance()
	get_tree().current_scene.add_child(explosion)
	
	explosion.visible = true
	explosion.global_position = self.global_position
	
	var explosion_sound = explosion.get_node("AudioStreamPlayer")
	var explosion_animation = explosion.get_node("AnimationPlayer")
	explosion_sound.play()
	explosion_animation.play("Explosion")


func _on_EnemyFireTimer_timeout():
	fire_weapon()
	
func fire_weapon():
	gun1.shoot_laser()
