extends CanvasLayer



# --- Signals ---
signal start_game
signal enable_weird
signal disable_weird



# --- Variables ---
var physics = false



# --- Standard ---
func _ready():
	pass


func _process(delta):
	pass



# --- Actuators ---
func update_score(score: int):
	$ScoreLabel.text = str(score) # str converts an object to string


func show_message(text: String):
	$Message.text = text
	$Message.show()


func hide_message(seconds: float):
	$MessageTimer.wait_time = seconds
	$MessageTimer.start()


func show_and_hide_message(text: String, seconds: float):
	show_message(text)
	hide_message(seconds)


func show_game_over():
	show_and_hide_message("Oh, you died.", 2)
	await $MessageTimer.timeout
	show_message("You're locked in.")
	$StartButton.show()



# --- Listeners ---
func _on_message_timer_timeout():
	$Message.hide()


func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()


func _on_weird_button_pressed():
	physics = !physics
	if physics:
		$WeirdButton.text = " x Weird physics"
		enable_weird.emit()
	else:
		$WeirdButton.text = "    Weird physics"
		disable_weird.emit()
