
extends WieldedItems

func primary():
	var tween = create_tween().set_parallel(true)
	var curr_position = position
	tween.tween_property($".", "rotation_degrees", 65, 0.1)
	tween.tween_property($".", "position", curr_position + Vector2(0,20), 0.1)
	
	tween.chain().tween_property($".", "rotation_degrees", -65, 0.005)
	tween.parallel().tween_property($".", "position", curr_position, 0.01)
	#tween.tween_property($".", "rotation", -65, 0.2)
