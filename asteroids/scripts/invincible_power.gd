extends Area2D
signal power_timeup


func _on_body_entered(body):
	if "Player" in body.name:
		$Timer.start()
		$PowerEquipAudio.play()
		body.is_invincible = true
		power_timeup.connect(Callable(body,"_on_power_timeup"))
		body.get_node("InvincibleCircle").show()
		$Sprite2D.hide()


func _on_timer_timeout():
	print("ded")
	$PowerLossAudio.play()
	await get_tree().create_timer(1).timeout
	power_timeup.emit()
	queue_free()
