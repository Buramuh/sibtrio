extends WorldParent

func _process(_delta):
	#if $Computer.in_interact_range == true:
		#print('interacting')
		#if Input.is_action_just_pressed("Interact"):
			#$Player/Camera2D/DialogPopup.visible = !$Player/Camera2D/DialogPopup.visible 
	pass


func _on_exit_gate_area_body_entered(body):
	var tween  = create_tween()
	tween.tween_property(body, "speed",0, 0.25)
	get_tree().change_scene_to_file("res://scenes/levels/test_area.tscn")
