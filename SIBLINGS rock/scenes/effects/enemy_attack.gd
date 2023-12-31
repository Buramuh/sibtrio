extends Area2D
@export	var damage: int = 2
@export var speed = 100
var direction: Vector2 = Vector2.UP

func _on_body_entered(body):
	if "hit" in body:
		body.hit(damage)
		
func _on_timer_timeout():
	queue_free()

func _process(delta):
	position += direction  * speed * delta
