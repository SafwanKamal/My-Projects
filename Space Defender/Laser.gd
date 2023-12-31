extends Node2D


export var velocity := Vector2(800, 0)

var HitEffect := preload("res://HitEffect.tscn")

func _ready():
	add_to_group("Laser")

func _process(delta):
	global_position += velocity * delta



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_area_entered(area):
	if not area.is_in_group("Laser"):
		var hitEffect := HitEffect.instance()
		get_tree().current_scene.add_child(hitEffect)
		hitEffect.global_position = self.global_position
		hitEffect.emitting = true
		hitEffect.oneshot = true
		queue_free()
