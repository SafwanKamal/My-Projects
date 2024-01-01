extends Projectile

func launch(pos:Vector2,rot):
	speed = 500
	super.launch(pos,rot)

func explode():
	$Sprite2D.hide()
	velocity = Vector2.ZERO
	$Explosion.show()
	$Explosion.play("smoke")

func _on_area_entered(area):
	explode()
	

func _on_explosion_animation_finished():
	queue_free()
