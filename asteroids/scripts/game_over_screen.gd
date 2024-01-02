extends Control

func show_score(score):
	$Panel/ScoreLabel.text = "Score: " + str(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
