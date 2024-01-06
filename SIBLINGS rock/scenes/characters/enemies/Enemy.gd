extends CharacterBody2D
@export var health = 10
@export var speed = 10
var original_color = Color("#d60000")

signal laser(pos, direction)
var hitbox_scene: PackedScene = preload("res://scenes/effects/enemy_attack.tscn")
var can_attack: bool = true

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

func _process(_delta):
	var player_location = get_tree().get_nodes_in_group("Players")[0].global_position
	var direction: Vector2 = (player_location - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	if can_attack == true:
		attack(direction)
		can_attack = false
		$AttackCooldown.start()
		

func attack(direction):
	#Making the hitbox
	var attack = hitbox_scene.instantiate() as Area2D
	attack.position = global_position
	attack.direction = direction
	attack.rotation_degrees = rad_to_deg(direction.angle())
	
	# Assuming this script is attached to the enemy node
	var world_node = get_tree().get_root().get_child(0)  # Assuming the parent is the world node
	var attacks_node = world_node.get_node("Attacks")
	
	# Check if the "Attacks" node is found
	if attacks_node:
		attacks_node.add_child(attack)
	else:
		print("Error: Attacks node not found.")


func _on_attack_cooldown_timeout():
	can_attack =true
