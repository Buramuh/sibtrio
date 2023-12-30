extends CharacterBody2D
@export var health = 10
@export var speed = 10

func hit(damage):
	health -= damage
	if health <= 0:
		perish()
	
func perish():
	$".".queue_free()
