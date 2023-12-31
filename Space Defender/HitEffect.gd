extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var oneshot := true
export var emitting := true
onready var particle := $Particles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	particle.one_shot = oneshot
	particle.emitting = emitting

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	queue_free()
