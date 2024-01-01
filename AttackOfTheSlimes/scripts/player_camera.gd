extends Camera2D

var shake_intensity := 0.0
var shake_duration := 0.0

func shake(intensity:float,duration:float):
	if intensity > shake_intensity and duration > shake_duration:
		shake_intensity = intensity
		shake_duration = duration
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shake_duration <= 0:
		offset = Vector2.ZERO
		shake_intensity = 0.0
		shake_duration = 0.0
		return
	
	shake_duration -= delta
	offset = Vector2(randf(), randf()) * shake_intensity
