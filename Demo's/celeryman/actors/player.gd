extends CharacterBody2D



# --- Signals ---
signal hit



# --- Variables ---
var screen_size 
var velocity_last


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
	velocity_last = Vector2.ZERO


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
	var speed2 = sqrt((SPEED**2) / 2)
	if Input.is_action_pressed("move_right") and Input.is_action_pressed("move_down"):
		velocity = Vector2(speed2, speed2)
	elif Input.is_action_pressed("move_right") and Input.is_action_pressed("move_up"):
		velocity = Vector2(speed2, -speed2)
	elif Input.is_action_pressed("move_left") and Input.is_action_pressed("move_down"):
		velocity = Vector2(-speed2, speed2)
	elif Input.is_action_pressed("move_left") and Input.is_action_pressed("move_up"):
		velocity = Vector2(-speed2, -speed2)

	elif Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_down") and !Input.is_action_pressed("move_up"):
		velocity = Vector2(SPEED, 0)
	elif Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_down") and !Input.is_action_pressed("move_up"):
		velocity = Vector2(-SPEED, 0)
	elif Input.is_action_pressed("move_down") and !Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_left"):
		velocity = Vector2(0, SPEED)
	elif Input.is_action_pressed("move_up") and !Input.is_action_pressed("move_right") and !Input.is_action_pressed("move_left"):
		velocity = Vector2(0, -SPEED)
	else:
		velocity = Vector2(0, 0)

	if Input.is_action_just_pressed("dash") and $DashCooldown.is_stopped():
		$DashTimer.start()
		$DashCooldown.start()



# Resetting
#-------------------------------------------------------------------------------
func stop():
	hit.emit()
	hide()
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	$AnimatedSprite2D.animation = "down"
	position = pos
	show()
	$CollisionShape2D.set_deferred("disabled", false)
