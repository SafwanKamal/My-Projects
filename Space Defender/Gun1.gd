extends Node2D

onready var bulletTimer = $BulletTimer
onready var laserSound = $LaserSound

var Laser := preload("res://Laser.tscn")

var can_fire := true


export var laser_rotation_degrees := 0
export var laser_velocity := Vector2(600, 0)
export var laser_audio_volume_Db := 0
export var will_play_sound := false
export var laser_offset := 0
#func _process(_delta):
#
#


func shoot_laser():
	if can_fire:
			
		var laser := Laser.instance()
		
		get_tree().current_scene.add_child(laser)
		
		laser.global_position = self.global_position + Vector2(laser_offset, 0)
		
		if will_play_sound:
			play_laser_sound()
		
		laser.velocity = laser_velocity
		laser.rotation_degrees += laser_rotation_degrees
		
		can_fire = false
		bulletTimer.start()

func play_laser_sound():
	laserSound.play()


func _on_BulletTimer_timeout():
	can_fire = true

