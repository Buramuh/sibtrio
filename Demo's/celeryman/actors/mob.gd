extends RigidBody2D
class_name Mob



# --- Exports ---
enum Variant {PHANTOM, SNIPER, SUITCASE}
@export var variant = Variant.PHANTOM



# --- Standard ---
func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	var mob_type = mob_types[variant]
	var model_table = { # A dictionary / table # (key -> value) # value = table.get(key)
		Variant.PHANTOM : $ShapeMob1, # key : value
		Variant.SNIPER : $ShapeMob2,
		Variant.SUITCASE : $ShapeMob3
	}
	model_table.get(variant).disabled = false
	$AnimatedSprite2D.play(mob_type)


func _process(delta):
	pass



# --- Listeners ---
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
