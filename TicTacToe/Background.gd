extends ColorRect


const x_player := 1
const o_player := 2
var line_first_point : Vector2
var line_last_point : Vector2
var line_has_to_be_drawn := false
var from_ready := true


export var c:Color = Color(0, 0, 0)

var state := [
			[0, 0, 0],
			[0, 0, 0],
			[0, 0, 0]
			]

func _draw():

	#(100, 0) -> (100, 300)
	var first_point := Vector2(100, 0)
	var last_point := Vector2(100, 300)
	draw_line(first_point, last_point, c, 3)
	#(200, 0) -> (200, 300)
	first_point = Vector2(200, 0)
	last_point = Vector2(200, 300)
	draw_line(first_point, last_point, c, 3)
	#(0, 100) -> (300, 100)
	first_point = Vector2(0, 100)
	last_point = Vector2(300, 100)
	draw_line(first_point, last_point, c, 3)
	#(0, 200) -> (300, 200)
	first_point = Vector2(0, 200)
	last_point = Vector2(300, 200)
	draw_line(first_point, last_point, c, 3)
	
	for i in range(3):
		for j in range(3):
			
			if state[i][j] == x_player:
				#Drawing the Cross
				first_point = Vector2(20 + 100 * i, 20 + 100 * j)
				last_point = Vector2(80 + 100 * i, 80 + 100 * j)
				draw_line(first_point, last_point, c, 3)
				first_point = Vector2(20 + 100 * i, 80 + 100 * j)
				last_point = Vector2(80 + 100 * i, 20 + 100 * j)
				draw_line(first_point, last_point, c, 3)
			if state[i][j] == o_player:
				#Drawing the node
				var center = Vector2(50 + 100 * i, 50 + 100 * j)
				draw_circle(center, 40, c)
		
		
		if line_has_to_be_drawn:
			draw_line(line_first_point, line_last_point, c, 4)
	


# Called when the node enters the scene tree for the first time.
func _ready():
	from_ready = true
	_draw()



func _on_mainlevel_state_change(pos, current_player):
	state[pos.x][pos.y] = current_player
	update()


func _on_mainlevel_game_over(line_start, line_end):
	line_first_point = Vector2(line_start.x * 100 + 50, line_start.y * 100 + 50)
	line_last_point = Vector2(line_end.x * 100 + 50, line_end.y * 100 + 50)
	line_has_to_be_drawn = true
	update()
