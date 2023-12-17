extends Node2D
class_name WorldParent

var p_attack_scene: PackedScene = preload("res://scenes/effects/keyboard_attack.tscn")

func _ready():
	pass # Replace with function body.



func _on_player_primary_attack(pos, direction):
	var attack = p_attack_scene.instantiate() as Area2D
	attack.position = pos
	attack.rotation_degrees = direction+90
	
	$Attacks.add_child(attack)
