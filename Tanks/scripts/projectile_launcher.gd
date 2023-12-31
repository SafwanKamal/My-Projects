extends Node2D

signal shot(type)

var parent:Node2D
var gun:Node2D

enum type {BULLET,MISSILE,MORTER}

@export var bullet_scene:PackedScene
@export var missile_scene:PackedScene
@export var morter_scene:PackedScene

func _ready():
	parent = get_parent()
	gun = parent.find_child("GunPivot")

func shoot(projectile_type:type):
	if not gun:
		gun = parent.find_child("GunPivot")
	var projectile_scene:PackedScene
	var timer:Timer
	match projectile_type:
		type.BULLET:
			projectile_scene = bullet_scene
			timer = $BulletTimer
		type.MISSILE:
			projectile_scene = missile_scene
			timer = $MissileTimer
		type.MORTER:
			projectile_scene = morter_scene
			timer = $MorterTimer
	if timer.is_stopped():
		var projectile = projectile_scene.instantiate()
		projectile.launch(gun.find_child("Marker2D").global_position,gun.global_rotation)
		get_tree().root.get_child(0).add_child(projectile)
		timer.start()
		shot.emit(projectile_type)
