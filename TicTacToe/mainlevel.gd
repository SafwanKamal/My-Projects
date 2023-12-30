extends Node2D

#1 -> Cross, 2 -> Node

#signals when a move is made
signal state_change(pos, current_player)

#signal for drawing the winning line
signal game_over(line_start, line_end)

#Constants
const x_player := 1
const o_player := 2
const human_player := x_player
const ai_player := o_player
const base_state : int = 0
const default_illegal_move := Vector3(-1, -1, -1)
const board_size = 3
const winning_length = 3


#State variables
var current_player := x_player
var game_over := false
var move_number : int = 0
var o_center_taken := false

#these variable are being used for drawing the winning line

var line_start : Vector2
var line_end : Vector2
var winning_line_drawn := false

#variable will store which position was changed on the board
#so that, mainlevel can signal that to Background, for drawing
var changed_position : Vector2

#Represents the board
#Here though the board is 3 * 3
#We are going with 4 * 4
#So that out_of_bounds errors are not encounterd
#And for a better optimised and more scalable win checking function
var state : Array = [
			[base_state, base_state, base_state, base_state],
			[base_state, base_state, base_state, base_state],
			[base_state, base_state, base_state, base_state],
			[base_state, base_state, base_state, base_state],
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
	for i in range(0, board_size):
		for j in range(0, board_size):
			if state[i][j] == current_player:
				var right_not_found := false
				var down_not_found := false
				var diagonal_left_not_found := false
				var diagonal_right_not_found := false
				var won := true
				for k in range(1, winning_length):
					#. . .
					#. .
					#.   .
					if not right_not_found:
						if i + k >= board_size:
							right_not_found = true
						elif state[i][j] != state[i + k][j]:
							right_not_found = true
						
					if not down_not_found:
						if j + k >= board_size:
							down_not_found = true
						elif state[i][j] != state[i][j + k]:
							down_not_found = true
						
					if not diagonal_right_not_found:
							
						if i + k >= board_size or j + k >= board_size:
							diagonal_right_not_found = true
						elif state[i][j] != state[i + k][j + k]:
							diagonal_right_not_found = true
						
					if not diagonal_left_not_found:
							
						if i - k < 0 or j + k >= board_size:
							diagonal_left_not_found = true
						elif state[i][j] != state[i - k][j + k]:
							diagonal_left_not_found = true
					
					if right_not_found and down_not_found and diagonal_left_not_found and diagonal_right_not_found:
						won = false
						break
				if won == true:
					line_start = Vector2(i, j)
					if not diagonal_right_not_found:
						
						line_end = Vector2(i + winning_length - 1, j + winning_length - 1)
						return true
					if not diagonal_left_not_found:
						line_end = Vector2(i - winning_length + 1, j + winning_length - 1)
						return true
					if not right_not_found:
						line_end = Vector2(i + winning_length - 1, j)
						return true
					if not down_not_found:
						line_end = Vector2(i, j + winning_length - 1)
						return true
					return true

	return false		

#This function iterates over the board and returns (player_whose_winning_move, position.x, position.y)
#Returns the default illegal move if not such move is found
func next_move_won(player : int, opponent_player : int, check_both_players : bool) -> Vector3:
	#Setting a default move, which means there is no next move that will win
	var winning_position := default_illegal_move
	
	for i in range(3):
		for j in range(3):
			if state[i][j] == base_state:			
				state[i][j] = player
				
				#checking if the player wins and returning if that is the case
				if won(player) == true:
					winning_position = Vector3(player, i, j)
					state[i][j] = base_state
					return winning_position
				
				
				#checking if the opponent player wins, not returning at that moment
				if check_both_players:
					state[i][j] = opponent_player
					if won(opponent_player) == true:
						winning_position = Vector3(opponent_player, i, j)
					
				state[i][j] = base_state
	

	
	return winning_position

func structure_targeting(player : int, opponent_player : int, structure) -> bool:

	var cell : Vector2
	var previous_cell : Vector2
	var at_least_one_found := false
		
	#Here first checking if there is any unoccupied cell in the structure
	#Making that move if only that move has the chance to win
	#in the 2nd next turn
		
	for cell_name in structure.keys():
		cell = structure[cell_name]
		#storing the value of the current cell_name, for using it later on
		if state[cell.x][cell.y] == base_state:
			if at_least_one_found == true:
				state[previous_cell.x][previous_cell.y] = base_state
			at_least_one_found = true
			state[cell.x][cell.y] = player
			changed_position = cell
			if next_move_won(player, opponent_player, false) != default_illegal_move:
				return true
			previous_cell = cell
	#There was no such move that wins in the 2nd next turn 
	#So if available, give any move to occupy a cell of the structure

	return at_least_one_found

func x_1_ai() -> void:
	var player := x_player
	var opponent_player := o_player
	
	
	var next_move := next_move_won(player, opponent_player, true)
	
	if next_move != default_illegal_move:
		#Chcking if the move found by the Ai is winning in this turn
		if next_move.x == player:
			game_over = true
		#Here the game still continues because the given move was a forced move
		changed_position = Vector2(next_move.y, next_move.z)
		state[next_move.y][next_move.z] = player
		return
	
	#Player 'o' has committed a terrible blunder
	#pounce on it and win
	if move_number == 3 and o_center_taken == false:
		#if 'o' took the cells in the 'plus'
		#then we have to occupy the center
		for cell_name in plus.keys():
			var cell = plus[cell_name]
			if state[cell.x][cell.y] == opponent_player:
				state[1][1] = player
				changed_position = Vector2(1, 1)
				return
		#if 'o' took the cells in the corners
		#then the game logic from here on works perfectly
	
	
	#Then cheking all the corners
	var made_a_move := false
	made_a_move = structure_targeting(player, opponent_player, corners)
	
	if made_a_move:
		return

	#Then cheking for the center
	if state[center.x][center.y] == 0:
		state[center.x][center.y] = player
		return
	
	#if nothing else, targer the others
	structure_targeting(player, opponent_player, plus)
	
	return

func o_2_ai() -> void:
	var player := o_player
	var opponent_player := x_player
	
	
	var next_move := next_move_won(player, opponent_player, true)
	
	if next_move != default_illegal_move:
		#Chcking if the move found by the Ai is winning in this turn
		if next_move.x == player:
			game_over = true
		#Here the game still continues because the given move was a forced move
		changed_position = Vector2(next_move.y, next_move.z)
		state[next_move.y][next_move.z] = player
		return
	
	#This is player2 or 'O's first move
	#So target center if available
	#or else, target a corner
	if move_number == 2:
		#Center
		if state[center.x][center.y] == base_state:
			state[center.x][center.y] = player
			changed_position = center
			o_center_taken = true
			return
		#Corners
		
		o_center_taken = false
		
		#All the corners are available at this stage
		#So choosing the top left one randomely
		#Doesn't matter which you choose
		state[0][0] = player
		changed_position = Vector2(0, 0)
		return
		
	#This is if 'O' chose the center
	if o_center_taken:
		#Then first target the cells in the plus
		var p1 : Vector2
		var p2 : Vector2
		var c : Vector2

		p1 = plus["plus1"]
		p2 = plus["plus4"]
		if state[p1.x][p1.y] == x_player or state[p2.x][p2.y] == x_player:
			p1 = plus["plus2"]
			p2 = plus["plus3"]
			if state[p1.x][p1.y] == x_player or state[p2.x][p2.y] == x_player:
				p1 = plus["plus3"]
				p2 = plus["plus4"]
				c = corners["corner4"]
				if state[p1.x][p1.y] == x_player and state[p2.x][p2.y] == x_player:
					if state[c.x][c.y] == base_state:
						state[c.x][c.y] = o_player
						changed_position = Vector2(c.x, c.y)
						return
				
				p1 = plus["plus2"]
				p2 = plus["plus4"]
				c = corners["corner2"]
				if state[p1.x][p1.y] == x_player and state[p2.x][p2.y] == x_player:
					if state[c.x][c.y] == base_state:
						state[c.x][c.y] = o_player
						changed_position = Vector2(c.x, c.y)
						return
				
				p1 = plus["plus2"]
				p2 = plus["plus1"]
				c = corners["corner1"]
				if state[p1.x][p1.y] == x_player and state[p2.x][p2.y] == x_player:
					if state[c.x][c.y] == base_state:
						state[c.x][c.y] = o_player
						changed_position = Vector2(c.x, c.y)
						return
				
				p1 = plus["plus3"]
				p2 = plus["plus1"]
				c = corners["corner3"]
				if state[p1.x][p1.y] == x_player and state[p2.x][p2.y] == x_player:
					if state[c.x][c.y] == base_state:
						state[c.x][c.y] = o_player
						changed_position = Vector2(c.x, c.y)
						return
				var made_a_move := structure_targeting(player, opponent_player, corners)
				if made_a_move:
					return

		var made_a_move := structure_targeting(player, opponent_player, plus)
		if made_a_move:
			return
			
		#Then all others
		structure_targeting(player, opponent_player, corners)
		
				
	#'O' didn't take the center in it's first move
	else:
		#Then targetting the corners first
		var made_a_move = structure_targeting(player, opponent_player, corners)
		
		if made_a_move:
			return
		
		#Then everything else
		structure_targeting(player, opponent_player, plus)
	
	return




func game_ai(player: int):
	if player == x_player:
		x_1_ai()
	else:
		o_2_ai()
	
	return



func _process(_delta):

	if game_over:
		if not winning_line_drawn:
			won(x_player)
			won(o_player)
			emit_signal("game_over", line_start, line_end)
			winning_line_drawn = true
		
		return
		
	if move_number >= 9:
		game_over = true
		winning_line_drawn = true
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
			
			if won(current_player) == true:
				game_over = true
				return
			else:
				current_player = ai_player
				return
	
	
	return			
			

		
