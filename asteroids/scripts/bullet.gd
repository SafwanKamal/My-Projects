extends Area2D

@export var max_speed = 200

var direction:Vector2
var speed := 0

func _physics_process(delta):
	position += direction * speed * delta
	
func launch(pos:Vector2,dir:Vector2,rot):
	position = pos
	direction = dir
	speed = max_speed
	rotation += rot


func _on_area_entered(area):
	get_tree().queue_delete(self)

