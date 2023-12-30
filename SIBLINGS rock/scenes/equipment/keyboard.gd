
extends WieldedItems
var hitbox_scene: PackedScene = preload("res://scenes/effects/keyboard_attack.tscn")
	
func primary(facing):
	#Attack animation
	var tween = create_tween().set_parallel(true)
	var curr_position = position
	tween.tween_property($".", "rotation_degrees", 65, 0.1)
	tween.tween_property($".", "position", curr_position + Vector2(0,20), 0.1)
	
	tween.chain().tween_property($".", "rotation_degrees", -65, 0.005)
	tween.parallel().tween_property($".", "position", curr_position, 0.01)
	
	
	#Making the hitbox
	var attack = hitbox_scene.instantiate() as Area2D
	attack.position = $AttackMarkers/Marker2D.global_position
	attack.rotation_degrees = facing+90
	
	#$Hitboxes.add_child(attack)
	return attack
