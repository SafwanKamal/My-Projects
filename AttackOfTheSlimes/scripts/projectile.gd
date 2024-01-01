extends Area2D

class_name Projectile

var velocity:Vector2 = Vector2.ZERO

var speed:int

func launch(pos:Vector2,rot):
	position = pos
	rotation = rot
	velocity = Vector2(speed,0).rotated(rotation)

func _physics_process(delta):
	position += velocity * delta


