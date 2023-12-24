extends CharacterBody2D

var player_near: bool = false
var can_laser: bool = true
var active_shooter: int = 1
var health: int = 5

signal laser(pos, direction)

func _process(_delta):
	if player_near == true:
		look_at(Globals.player_pos)
		if can_laser == true:
			var laser_spawns = $LaserSpawnPosition.get_children()
			var pos: Vector2 = laser_spawns[active_shooter%2].global_position
			
			var direction: Vector2 = (Globals.player_pos - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			active_shooter +=1
			$Node/LaserCooldown.start()
			
func hit():
	if $Node/InvulnTimer.is_stopped():
		print('Im hit')
		health -= 2
		if health <= 0:
			queue_free()
		$Node/InvulnTimer.start()


func _on_attack_area_body_entered(_body):
	player_near = true


func _on_attack_area_body_exited(_body):
	player_near = false


func _on_laser_cooldown_timeout():
	can_laser = true
