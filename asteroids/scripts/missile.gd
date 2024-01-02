extends Area2D

var speed:int

@export var explosion_scene:PackedScene
@export var max_speed := 50

var direction:Vector2



func _physics_process(delta):
	position += direction * speed * delta

func launch(pos:Vector2,dir:Vector2,rot):
	position = pos
	direction = dir
	speed = max_speed
	rotation += rot
	
func explode():
	$CollisionShape2D.shape.radius = 10
	$CollisionShape2D.shape.height = 20
	speed = 0
	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position
	get_tree().root.get_child(0).add_child(explosion)
	$Sprite2D.hide()
	$AfterExplosionImage.show()
	await get_tree().create_timer(0.5).timeout
	queue_free()



func _on_area_entered(area):
	explode()
