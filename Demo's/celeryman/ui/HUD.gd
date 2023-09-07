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


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Oh, you died.")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout # Waits for timer timeout signal to trigger/emit
	$Message.text = "You're locked in."
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
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
