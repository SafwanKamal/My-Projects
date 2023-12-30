extends Node2D


var playerScore := 0
var opponentScore := 0

signal game_over()


func _ready():
	$OpponentScore.text = String(opponentScore)
	$PlayerScore.text = String(playerScore)


func _on_LeftWall_body_exited(body):
	opponentScore += 1
	$OpponentScore.text = String(opponentScore)
	$ScoringSound.play()
	yield(get_tree().create_timer(0.10), "timeout")
	$ScoringSound.stop()
	emit_signal("game_over")


func _on_RightWall_body_exited(body):
	playerScore += 1
	$PlayerScore.text = String(playerScore)
	$ScoringSound.play()
	yield(get_tree().create_timer(0.10), "timeout")
	$ScoringSound.stop()
	emit_signal("game_over")
