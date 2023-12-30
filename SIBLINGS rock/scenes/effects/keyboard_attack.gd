extends Area2D
@export	var damage: int = 2


func _on_body_entered(body):
	if "hit" in body:
		body.hit(damage)
		
func _on_timer_timeout():
	queue_free()
