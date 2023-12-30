extends Node2D

#1 -> Cross, 2 -> Node

#signals when a move is made
signal state_change(pos, current_player)

#Constants
const x_player := 1
const o_player := 2
const human_player := x_player
const ai_player := o_player
const base_state : int = 0

#State variables
var current_player := x_player
var game_over := false
var move_number : int = 0
var o_center_taken := false


#variable will store which position was changed on the board
#so that, mainlevel can signal that to Background, for drawing
var changed_position : Vector2


#Represents the board
var state : Array = [
			[base_state, base_state, base_state],
			[base_state, base_state, base_state],
			[base_state, base_state, base_state]
		]

var corners :={
	"corner1" : Vector2(0, 0),
	"corner2" : Vector2(0, 2),
	"corner3" : Vector2(2, 0),
	"corner4" : Vector2(2, 2)
}

var plus := {
	"plus1" : Vector2(1, 0),
	"plus2" : Vector2(0, 1),
	"plus3" : Vector2(2, 1),
	"plus4" : Vector2(1, 2)
}

var center := Vector2(1, 1)


func won(current_player) -> bool:
	if state[0][0] == state[1][1] and state[2][2] == current_player and state[1][1] == state[2][2]:
		return true
	if state[0][2] == state[1][1] and state[2][0] == current_player and state[1][1] == state[2][0]:
		return true
	if state[0][0] == state[1][0] and state[2][0] == current_player and state[1][0] == state[2][0]:
		return true
	if state[0][0] == state[0][1] and state[0][2] == current_player and state[0][1] == state[0][2]:
		return true
	if state[1][0] == state[1][1] and state[1][2] == current_player and state[1][1] == state[1][2]:
		return true
	if state[0][1] == state[1][1] and state[2][1] == current_player and state[1][1] == state[2][1]:
		return true
	if state[2][0] == state[2][1] and state[2][2] == current_player and state[2][1] == state[2][2]:
		return true
	if state[0][2] == state[1][2] and state[2][2] == current_player and state[1][2] == state[2][2]:
		return true


	return false


func x_1_ai() -> void:
	var player := x_player
	var opponent_player := o_player
	#First cheking if there is any move that cofirms playerx's win
	for i in range(3):
		for j in range(3):
			if state[i][j] == base_state:			
				state[i][j] = player
				#Checking
				var w = won(player)
				if w == true:
					changed_position = Vector2(i, j)
					game_over = true
					return
				else:
					state[i][j] = base_state
					
	#Then checking if there is any move the opponent can play in
	#next turn that cofirms the opponent_player's win
	for i in range(3):
		for j in range(3):
			if state[i][j] == base_state:			
				state[i][j] = opponent_player
				#Checking
				var w = won(opponent_player)
				if w == true:
					state[i][j] = player
					changed_position = Vector2(i, j)
					return
				else:
					state[i][j] = base_state
	
	#Then cheking all the corners
	for corner_names in corners.keys():
		var corner = corners[corner_names]
		if state[corner.x][corner.y] == 0:
			state[corner.x][corner.y] = player
			changed_position = corner
			corners.erase(corner_names)
			return
	
	#Then cheking for the center
	if state[center.x][center.y] == 0:
		state[center.x][center.y] = player
		return
	
	#if nothing else, targer the others
	for cell_name in plus.keys():
		var cell = plus[cell_name]
		if state[cell.x][cell.y] == 0:
			state[cell.x][cell.y] = player
			changed_position = cell
			plus.erase(cell_name)
			return
	
	return

func o_2_ai() -> void:
	var player := 2
	var opponent_player := 1
	#First cheking if there is any move that cofirms playerx's win
	for i in range(3):
		for j in range(3):
			if state[i][j] == base_state:			
				state[i][j] = player
				#Checking
				var w = won(player)
				if w == true:
					changed_position = Vector2(i, j)
					game_over = true
					return
				else:
					state[i][j] = base_state
					
	#Then checking if there is any move the opponent can play in
	#next turn that cofirms the opponent_player's win
	for i in range(3):
		for j in range(3):
			if state[i][j] == base_state:			
				state[i][j] = opponent_player
				var w = won(opponent_player)
				if w == true:
					state[i][j] = player
					changed_position = Vector2(i, j)
					return
				else:
					state[i][j] = base_state
	
	#This is player2 or 'O's first move
	#So target center if available
	#or else, target a corner
	if move_number == 2:
		#Center
		if state[center.x][center.y] == 0:
			state[center.x][center.y] = player
			changed_position = center
			o_center_taken = true
			return
		#Corners
		else:
			o_center_taken = false
			for corner_names in corners.keys():
				var corner = corners[corner_names]
				if state[corner.x][corner.y] == 0:
					state[corner.x][corner.y] = player
					changed_position = corner
					corners.erase(corner_names)
					return

		
	#This is if 'O' chose the center
	if o_center_taken:
		#Then first target the cells in the plus
		for cell_name in plus.keys():
			var cell = plus[cell_name]
			if state[cell.x][cell.y] == 0:
				state[cell.x][cell.y] = player
				changed_position = cell
				plus.erase(cell_name)
				return
		#Then all others
		for corner_names in corners.keys():
			var corner = corners[corner_names]
			if state[corner.x][corner.y] == 0:
				state[corner.x][corner.y] = player
				changed_position = corner
				corners.erase(corner_names)
				return
	#'O' didn't take the center in it's first move
	else:
		#Then targetting the corners first
		for corner_names in corners.keys():
			var corner = corners[corner_names]
			if state[corner.x][corner.y] == 0:
				state[corner.x][corner.y] = player
				changed_position = corner
				corners.erase(corner_names)
				return
		
		#Then everything else
		for cell_name in plus.keys():
			var cell = plus[cell_name]
			if state[cell.x][cell.y] == 0:
				state[cell.x][cell.y] = player
				changed_position = cell
				plus.erase(cell_name)
				return
	
	return

func game_ai(player: int):
	
	if player == 1:
		x_1_ai()
	else:
		o_2_ai()
	
	return
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_over:
		return
		
	if move_number >= 9:
		game_over = 1
		return
	
	#Doing AI's move
	if current_player == ai_player:
		move_number += 1
		game_ai(current_player)
		emit_signal("state_change", changed_position, current_player)
		current_player = human_player
	
	if Input.is_action_pressed("mouse_click") and current_player == human_player:
		changed_position = get_viewport().get_mouse_position()
		changed_position.x = int(floor(changed_position.x / 100))
		changed_position.y = int(floor(changed_position.y / 100))
		
		if state[changed_position.x][changed_position.y] == base_state:
			move_number += 1
			emit_signal("state_change", changed_position, current_player)
			state[changed_position.x][changed_position.y] = current_player
			var w := won(current_player)
			
			if w == true:
				game_over = true
				return
			else:
				current_player = ai_player
				return
	
	
	return			
			

		
