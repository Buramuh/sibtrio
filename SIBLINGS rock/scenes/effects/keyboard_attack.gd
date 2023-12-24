extends Area2D



func _on_body_entered(body):
	if "hit" in body:
		body.hit()
	queue_free()


func _on_timer_timeout():
	queue_free()
