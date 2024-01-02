extends Marker2D

@export var bullet_scene:PackedScene
@export var cooldown_time:float = 1

@onready var shoot_sound = $AudioStreamPlayer2D

var parent:Node2D

var cooldown:bool = true

func _ready():
	parent = get_parent()
	$CooldownTimer.wait_time = cooldown_time

func shoot():
	if not cooldown:
		return
	var bullet = bullet_scene.instantiate()
	bullet.launch(global_position,Vector2.from_angle(parent.rotation+PI/2),parent.rotation+PI/2)
	get_tree().root.get_child(0).add_child(bullet)
	shoot_sound.play()
	cooldown = not cooldown
	$CooldownTimer.start()
	
func _on_cooldown_timer_timeout():
	cooldown = not cooldown
