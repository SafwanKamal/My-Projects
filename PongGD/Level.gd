extends Node2D

var ball
var opponent_score = 0
var player_score = 0
var timer



func _ready():
	ball = $Ball
	timer = $CountDownTimer
	$Timer.visible = false

func _process(delta):
	$PlayerScore.text = str(player_score)
	$OpponentScore.text = str(opponent_score)
	if $Timer.visible:
		$Timer.text = str(int(timer.time_left) + 1)
	#if ball.position.x <=0 || ball.position.x >= 1080:
	#	ball.reset()


func _on_Left_body_entered(body):
	game_over(false)


func _on_Right_body_entered(body):
	game_over(true)


func _on_CountDownTimer_timeout():
	$Timer.visible = false
	get_tree().call_group("BallGroup","reset")
	
func game_over(opponent_scored):
	$ScoreSound.play()
	$Player.position.y = 320
	$Opponent.position.y = 320
	get_tree().call_group("BallGroup","stop_ball")
	if opponent_scored:
		opponent_score += 1
	else:
		player_score += 1
	$Timer.visible = true
	$Timer.show()
	timer.start()
