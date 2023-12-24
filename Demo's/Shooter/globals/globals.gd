extends Node

signal stat_change

var laser_amount = 20:
	get:
		return laser_amount
	set(value):
		laser_amount = value
		stat_change.emit()
		
var grenade_amount = 5:
	get:
		return grenade_amount
	set(value):
		grenade_amount = value
		stat_change.emit()
		
var player_vuln = true
var health = 60:
	get:
		return health
	set(value):
		if value > health:
			health = value
		else:
			if player_vuln:
				health = min(value, 100)
				player_vuln = false
				player_invulnerable_timer()
		stat_change.emit()
				
func player_invulnerable_timer():
	await get_tree().create_timer(0.5).timeout
	player_vuln = true

var player_pos: Vector2
