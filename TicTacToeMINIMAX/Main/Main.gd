extends Node

var screen_size: Vector2 
var x_unit: int
var y_unit: int


var board = [[0,0,0], #tic tac toe board
			[0,0,0],
			[0,0,0]]

const O = 1
const X = 10

var turn = X

var move_number = 1

var game_over = false

const MAXIMUM_VALUE = 1#best utcome for X
const MINIMUM_VALUE = -1#best utcome for O
	
func _ready():
	screen_size = get_viewport().size
	x_unit = (screen_size.x / 3)
	y_unit = (screen_size.y / 3)

func won(player):
	var sum_x = 0
	var sum_y = 0
	var sum_diag_1 = 0
	var sum_diag_2 = 0
	var winning_score = player * 3
	for i in range(0,3):
		#diagonal
		sum_diag_1 += board[i][i]
		sum_diag_2 += board[2-i][i]
		for j in range(0,3):
			#vertical
			sum_y += board[i][j]
			#horizontal
			sum_x += board[j][i]
		if sum_x == winning_score:
			return true
		else:
			sum_x = 0
		if sum_y == winning_score:
			return true
		else:
			sum_y = 0
	
	return sum_diag_1 == winning_score or sum_diag_2 == winning_score
			
func draw():
	return move_number == 10

func update(i,j):
	#making move
	board[i][j] = turn
	#increamenting move number
	move_number += 1 
	#creating a new player symbol
	var symbol = PlayerSymbol.new(turn==X,i,j)
	#adding symbol node to group
	symbol.add_to_group("symbols")
	#adding the node as a child node of the main scene
	add_child(symbol)
	#checking if the game is over
	game_over = won(turn) or draw()
	#changing turn
	turn = X if turn == O else O
	
	

func reset_board():
	#deleting nodes from the scene tree
	get_tree().call_group("symbols","queue_free")
	#resetting game stats
	game_over = false
	turn = X
	move_number = 1
	#resetting board to base state
	for i in range(0,3):
		for j in range(0,3):
			board[i][j] = 0


func _process(delta):
	if not game_over and Input.is_action_pressed("move"):
		var mouse_position = get_viewport().get_mouse_position()
		#finding index of the square on board player clicked on
		var x: int = mouse_position.x / x_unit
		var y: int = mouse_position.y / y_unit
		#checking if the square is empty
		if board[x][y] == 0:
			#making move and updating the board
			update(x,y)
			if game_over:
				$ResetTimer.start()
			else:
				minimax_ai()
				if game_over:
          $ResetTimer.start()

func minimax_ai(): #MINIMUM_VALUE = -1, MAXIMUM_VALUE = 1
	var best_move: Vector2
	var score:int
	var best_score:int
	#setting the worst outcome as best score
	if turn == X:
		best_score = MINIMUM_VALUE
	else:
		best_score = MAXIMUM_VALUE
		
	for i in range(0,3):
		for j in range(0,3):
			if board[i][j] == 0:
				#making move
				move_number += 1
				board[i][j] = turn
				#if it was X's turn or X just made its move, then it is now O's turn
				#and O is the minimizing player
				score = minimax(not turn==X)
				#undoing move
				move_number -= 1
				board[i][j] = 0
				if turn == X:
					if score > best_score:
						best_score = score
						best_move = Vector2(i,j)
				else:
					if score < best_score:
						best_score = score
						best_move = Vector2(i,j)
	update(best_move.x,best_move.y)

func minimax(is_maximizing):
	if won(X):
		return MAXIMUM_VALUE
	elif won(O):
		return MINIMUM_VALUE
	elif draw():
		return 0
	
	var best_score = null
	
	if is_maximizing:
		best_score = MINIMUM_VALUE
	else:
		best_score = MAXIMUM_VALUE
	
	for i in range(0,3):
		for j in range(0,3):
			if board[i][j] == 0:
				move_number += 1
				
				#making move
				if is_maximizing:
					board[i][j] = X
					best_score = max(minimax(false),best_score)
				else:
					board[i][j] = O
					best_score = min(minimax(true),best_score)
				#undoing move
				move_number -= 1
				board[i][j] = 0
	
	return best_score
