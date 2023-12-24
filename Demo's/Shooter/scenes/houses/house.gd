extends Area2D
signal player_entered(body)
signal player_exited(body)

func _on_body_entered(body):
	player_entered.emit(body)


func _on_body_exited(body):
	player_exited.emit(body)
