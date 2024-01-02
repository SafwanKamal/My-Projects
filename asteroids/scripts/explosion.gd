extends CPUParticles2D

func on_timer_timeout():
	emitting = false
	get_tree().queue_delete(self)
