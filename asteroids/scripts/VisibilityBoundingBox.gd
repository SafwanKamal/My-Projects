extends Node2D

var node:Node2D

var screen_rect:Rect2

func _ready():
	screen_rect = get_viewport_rect()
	node = get_parent()


func _process(delta):
	if node.position.x-node.radius > screen_rect.size.x:
		node.position.x = -node.radius
	elif node.position.x+node.radius < 0:
		node.position.x = screen_rect.size.x + node.radius
		
	if node.position.y+node.radius < 0:
		node.position.y = screen_rect.size.y+node.radius
	elif node.position.y-node.radius > screen_rect.size.y:
		node.position.y = -node.radius

