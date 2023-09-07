@icon("res://art/icon/player.png") #huh?? what does this do??

extends RigidBody2D
@export var speed = 175 # How fast the player will move (pixels/sec).
var screen_size 
var velocity_last
signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size #Why not var screen_size??
	velocity_last = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		$AnimatedSprite2D.play() # $ is shorthand for get_node()
	else:
		$AnimatedSprite2D.stop()
	linear_velocity = velocity.normalized() * speed
	
	#position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x > 0
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_h = false
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "down"
		$AnimatedSprite2D.flip_h = false
	else:
		if velocity_last.x != 0:
			$AnimatedSprite2D.animation = "idle_walk"
		elif velocity_last.y > 0:
			$AnimatedSprite2D.animation = "idle_down"
		elif velocity_last.y < 0:
			$AnimatedSprite2D.animation = "idle_up"
	velocity_last = velocity
	
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

