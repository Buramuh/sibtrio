extends RigidBody2D

const speed = 750
var explosion_active: bool = false
var explosion_radius : int = 300

func explode():
	$AnimationPlayer.play("Explosion")
	explosion_active = true

func _process(_delta):
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Entity") + get_tree().get_nodes_in_group("Container")
		
		for target in targets:
			var in_range = target.global_position.distance_to(global_position)
			if "hit" in target and in_range < explosion_radius:
				target.hit()
