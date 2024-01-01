extends Projectile


func launch(pos:Vector2,rot):
	speed = 200
	super.launch(pos,rot)
	$CPUParticles2D.emitting = true
	$CPUParticles2D.gravity = -velocity

func explode():
	velocity = Vector2.ZERO
	$CollisionShape2D.shape.radius = 25
	$CPUParticles2D.emitting = false
	$Missile.hide()
	$Explosion.show()
	$Explosion.play("fire")


func _on_area_entered(area):
	explode()
	#queue_free()->now executed when the animation is finished


func _on_explosion_animation_finished():
	queue_free()
