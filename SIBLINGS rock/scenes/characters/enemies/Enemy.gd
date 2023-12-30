extends CharacterBody2D
@export var health = 10
@export var speed = 10
var original_color = Color("#d60000")

func hit(damage):
	health -= damage

	var new_color = Color("#ffb1a5")
	
	var tween = create_tween()
	tween.tween_property($".", "modulate", new_color, 0.25)
	tween.chain().tween_property($".", "modulate", original_color, 0.25)

	if health <= 0:
		perish()
	
func perish():
	$".".queue_free()
