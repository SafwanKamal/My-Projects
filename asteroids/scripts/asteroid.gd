extends Area2D
signal player_hit
signal asteroid_hit
signal _spawn_smaller_asteroids(size:int,pos:Vector2)

@export var speed = 30
@export var rotation_speed = 1.5
@export var Explosion:PackedScene

var radius = 10
var images = ["res://Assets/Asteroid_01.png","res://Assets/Asteroid_02.png","res://Assets/Asteroid_03.png","res://Assets/Asteroid_04.png"]
var direction:Vector2
var rotation_direction

var size:int = 0

func _ready():
	$Sprite2D.texture = load(images.pick_random())
	direction = Vector2(randi_range(-1,1),randi_range(-1,1))
	rotation_direction = randi_range(-1,1)
	var scaleValue = float(1.0/(size+1))
	scale = Vector2(scaleValue,scaleValue)
	radius = radius * scaleValue
	speed /= scaleValue
	#print(scaleValue)
	

func _process(delta):
	position += direction * speed * delta
	rotation += rotation_direction * rotation_speed * delta


func explode(pos:Vector2):
	var explosion = Explosion.instantiate()
	explosion.position = pos
	get_tree().root.get_child(0).add_child(explosion)

func _on_area_entered(area):
	asteroid_hit.emit()
	_spawn_smaller_asteroids.emit(size,global_position)
	explode(global_position)
	queue_free()


func _on_body_entered(body):
	if "Player" in body.name and not body.is_invincible:
		player_hit.emit()
