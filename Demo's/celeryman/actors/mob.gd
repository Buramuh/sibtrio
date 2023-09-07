extends RigidBody2D



# --- Standard ---
func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	var mob_type = mob_types[randi() % mob_types.size()]
	var model_table = { # A dictionary / table # (key -> value) # value = table.get(key)
		"mob1" : $ShapeMob1, # key : value
		"mob2" : $ShapeMob2,
		"mob3" : $ShapeMob3
	}
	model_table.get(mob_type).disabled = false
	$AnimatedSprite2D.play(mob_type)


func _process(delta):
	pass



# --- Listeners ---
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
