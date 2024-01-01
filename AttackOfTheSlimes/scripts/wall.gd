extends Area2D


func _ready():
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)
	
func _on_area_entered(area):
	area.queue_free()
	
func _on_body_entered(body):
	body.queue_free()
