extends CharacterBody2D



# --- Signals ---
signal hit



# --- Variables ---
var screen_size 
var velocity_last


var SPEED = 500
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
	move_and_slide()
	
	
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
	# apply_force(Vector2.ZERO)
	
	
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

