extends WorldParent

func _process(_delta):
	if $Computer.in_interact_range == true:
		#print('interacting')
		if Input.is_action_just_pressed("Interact"):
			#$Player/Camera2D/DialogPopup.visible = !$Player/Camera2D/DialogPopup.visible 
