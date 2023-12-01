extends StaticBody2D
signal player_entered_gate(body)

func _on_area_2d_body_entered(body):
	print(body.collision_layer)
	print(body.collision_mask)
	print(collision_layer)
	print(collision_mask)

	
	player_entered_gate.emit(body)
