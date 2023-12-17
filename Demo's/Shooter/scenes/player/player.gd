extends CharacterBody2D
signal laser(pos, direction)
signal grenade(pos, direction)
signal update_stats()

var can_laser: bool = true
var can_grenade: bool = true


@export var max_speed: int = 1000
var speed: int = max_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed	
	move_and_slide()
	Globals.player_pos = position
	
	look_at(get_global_mouse_position())
	
	var player_direction = (get_global_mouse_position() - position).normalized()		

	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount >0:
		Globals.laser_amount -= 1
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]

		can_laser = false
		laser.emit(selected_laser.global_position, player_direction)
		$LaserParticles.emitting = true
		$Timers/TimerLaser.start(0.5)
		

	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount >0: 
		Globals.grenade_amount -= 1
		var grenade_markers = $GrenadeStartPositions2.get_children()
		var selected_grenade = grenade_markers[randi() % grenade_markers.size()]

		can_grenade = false
		grenade.emit(selected_grenade.global_position, player_direction)
		$Timers/TimerGrenade.start(2)

func hit():
	
	print("ouch")
	Globals.health -= 10
	if Globals.health  <= 0:
		print("game over!")

func _on_timer_timeout():
	can_laser = true

func _on_timer_grenade_timeout():
	can_grenade = true
	

