@icon("res://art/icon/player.png") #huh?? what does this do??

extends RigidBody2D
@export var speed = 175 # How fast the player will move (pixels/sec).
var screen_size 
var velocity_last
signal hit

var SPEED = 1500
var DASH = 45000
var THRESHOLD = 1

var can_dash = true

func dash_cooldown(seconds):
	$DashTimer.wait_time =seconds
	$DashTimer.start()	
	can_dash = false	
	await $DashTimer.timeout
	can_dash = true

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size #Why not var screen_size??
	velocity_last = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	var speed2 = sqrt((SPEED**2) / 2)
	
	if Input.is_action_pressed("move_right") and Input.is_action_pressed("move_down"):
		apply_force(Vector2(speed2, speed2))
	if Input.is_action_pressed("move_right") and Input.is_action_pressed("move_up"):
		apply_force(Vector2(speed2, -speed2))
	if Input.is_action_pressed("move_left") and Input.is_action_pressed("move_down"):
		apply_force(Vector2(-speed2, speed2))
	if Input.is_action_pressed("move_left") and Input.is_action_pressed("move_up"):
		apply_force(Vector2(-speed2, -speed2))
	
	
	
	if Input.is_action_pressed("dash"):
		if can_dash:
			var vel = linear_velocity.normalized()
			apply_force(Vector2(vel.x*DASH, vel.y*DASH))
			dash_cooldown(0.5)
	
	
	if Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_down") and !Input.is_action_pressed("move_up"):
		apply_force(Vector2(SPEED, 0))
	if Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_down") and !Input.is_action_pressed("move_up"):
		apply_force(Vector2(-SPEED, 0))
	if Input.is_action_pressed("move_down") and !Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_left"):
		apply_force(Vector2(0, SPEED))
	if Input.is_action_pressed("move_up") and !Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_left"):
		apply_force(Vector2(0, -SPEED))
	
	
	
	
	if linear_velocity.length() > THRESHOLD:
		$AnimatedSprite2D.play() # $ is shorthand for get_node()
	else:
		$AnimatedSprite2D.stop()
	#linear_velocity = velocity.normalized() * speed
	

	
	
	#position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	
	if linear_velocity.x > THRESHOLD or linear_velocity.x < -THRESHOLD:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = linear_velocity.x > 0
	elif linear_velocity.y < -THRESHOLD:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_h = false
	elif linear_velocity.y > THRESHOLD:
		$AnimatedSprite2D.animation = "down"
		$AnimatedSprite2D.flip_h = false
	else:
		if velocity_last.x > THRESHOLD or velocity_last.x < -THRESHOLD:
			$AnimatedSprite2D.animation = "idle_walk"
		elif velocity_last.y > THRESHOLD:
			$AnimatedSprite2D.animation = "idle_down"
		elif velocity_last.y < -THRESHOLD:
			$AnimatedSprite2D.animation = "idle_up"
	velocity_last = linear_velocity
	
	if reset_state == RESET_SHOW:
		reset_show()
	elif reset_state >= RESET_DELAY:
		reset_state += 1



func _on_body_entered(body):
	if body in get_tree().get_nodes_in_group("mobs"):
		stop()


# Resetting
#-------------------------------------------------------------------------------
var reset_pos

var RESET_TELEPORT = 0
var RESET_DELAY = 1
var RESET_SHOW = 2
var RESET_DONE = 3
var reset_state = RESET_DONE

var reset_rotation = false


func stop():
	hit.emit()
	hide()
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	$AnimatedSprite2D.animation = "down"
	reset_pos = pos
	reset_state = RESET_TELEPORT
	# Wakes up the player physics. Otherwise _integrate_forces() never happens.
	apply_force(Vector2.ZERO) 
	
	
func reset_teleport(state):
	state.transform = Transform2D(0, reset_pos)
	reset_state = RESET_DELAY

func reset_show():
	show()
	$CollisionShape2D.set_deferred("disabled", false)
	reset_state = RESET_DONE
	
	
func start_reset_rotation():
	reset_rotation = true

func _integrate_forces(state):
	if reset_state == RESET_TELEPORT:
		reset_teleport(state)
	if reset_rotation:
		state.transform = Transform2D(0, position)
		reset_rotation = false

