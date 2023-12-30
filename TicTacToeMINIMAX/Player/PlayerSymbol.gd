extends Sprite
class_name PlayerSymbol

const SCALE_VALUE := 0.7

const OFFSET := 5.0

var screen_rect

var index

func _ready():
	screen_rect = get_viewport().size
	position.x = index.x * screen_rect.x/3 + screen_rect.x/3/2 + OFFSET
	position.y = index.y * screen_rect.y/3 + screen_rect.y/3/2 + OFFSET

func _init(x_symbol:bool,x:int,y:int):
	if x_symbol:
		texture = load("res://Player/X.png")
	else:
		texture = load("res://Player/O.png")
	scale = Vector2(SCALE_VALUE,SCALE_VALUE)
	index = Vector2(x,y)
