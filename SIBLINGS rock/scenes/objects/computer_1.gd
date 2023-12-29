extends StaticBody2D
var in_interact_range: bool = false:
	get:
		return(in_interact_range)
	set(value):
		in_interact_range = value
		$InteractIcon.visible = value		

func _on_interaction_zone_body_entered(body):
	
	in_interact_range = true
	print("body entereed")


func _on_interaction_zone_body_exited(body):
	in_interact_range = false
	print("body left")
