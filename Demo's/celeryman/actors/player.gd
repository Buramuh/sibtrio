extends CharacterBody2D



# --- Signals ---
signal hit



# --- Variables ---
var screen_size

var vec_move_last = Vector2.ZERO

var SPEED = 2
var DASH = 65000
var THRESHOLD = 50 

var can_dash = true
var doing_dash = false



func dash_cooldown_and_timer(wait,timer):
	$DashCooldown.wait_time = wait
	$DashTimer.wait_time = timer
	$DashCooldown.start()
	$DashTimer.start()
	can_dash = false
	doing_dash = true
	await $DashTimer.timeout
	doing_dash = false
	await $DashCooldown.timeout
	can_dash = true



# --- Standard ---
func _ready():
	screen_size = get_viewport_rect().size #Why not var screen_size??
	$AnimatedSprite2D.play()


func _physics_process(delta): #'delta' is the elapsed time since the previous frame.
	if $DashTimer.is_stopped():
		process_keys()

	var result_velocity = velocity
	if not $DashTimer.is_stopped():
		result_velocity *= 5

	var collision = move_and_collide(result_velocity)
	if collision != null and collision.get_collider().is_in_group("mobs"):
		stop()



# Key Processing
#-------------------------------------------------------------------------------
func process_keys():
	var vec_move = calc_move()
	update_walk_animations(vec_move)
	update_idle_animations(vec_move)
	process_dash(vec_move)
	velocity = vec_move.normalized() * SPEED
	vec_move_last = vec_move


func calc_move():
	var vec_move = Vector2()
	if Input.is_action_pressed("move_down"):
		vec_move.y = 1
	if Input.is_action_pressed("move_up"):
		vec_move.y = -1
	if Input.is_action_pressed("move_right"):
		vec_move.x = 1
	if Input.is_action_pressed("move_left"):
		vec_move.x = -1
	return vec_move


func update_walk_animations(vec_move):
	if vec_move.x < 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = false
	elif vec_move.x > 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = true
	elif vec_move.y > 0:
		$AnimatedSprite2D.animation = "down"
		$AnimatedSprite2D.flip_h = false
	elif vec_move.y < 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_h = false


func update_idle_animations(vec_move):
	if vec_move == Vector2.ZERO and vec_move_last != Vector2.ZERO:
		if vec_move_last.x != 0:
			$AnimatedSprite2D.animation = "idle_walk"
		elif vec_move_last.y < 0:
			$AnimatedSprite2D.animation = "idle_up"
		elif vec_move_last.y > 0:
			$AnimatedSprite2D.animation = "idle_down"


func process_dash(vec_move):
	if Input.is_action_just_pressed("dash") and $DashCooldown.is_stopped():
		$DashTimer.start()
		$DashCooldown.start()
		if vec_move.x != 0:
			$AnimatedSprite2D.animation = "dash_sideways"
		elif vec_move.y == -1:
			$AnimatedSprite2D.animation = "dash_up"
		elif vec_move.y == 1:
			$AnimatedSprite2D.animation = "dash_down"



# Resetting
#-------------------------------------------------------------------------------
func stop():
	hit.emit()
	hide()
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	$AnimatedSprite2D.animation = "idle_down"
	position = pos
	show()
	$CollisionShape2D.set_deferred("disabled", false)
