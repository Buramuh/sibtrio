extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game
signal weird_enabled
signal weird_disabled
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Oh, you died.")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "You're locked in."
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_message_timer_timeout():
	$Message.hide()

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()



var physics = false

func _on_weird_button_pressed():
	physics = !physics
	if physics:
		$WeirdButton.text = " x Weird physics"
		weird_enabled.emit()
		#var mobs = get_tree().get_nodes_in_group("mobs")
		#for mob in mobs:
		#	mob.collision_mask = 1
		
	else:
		$WeirdButton.text = "    Weird physics"
		weird_disabled.emit()
		#var mobs = get_tree().get_nodes_in_group("mobs")
		#for mob in mobs:
		#	mob.collision_mask = 0
		


#var physics = false

#func _on_weird_button_pressed():
	#var physics = true
	#pass 
