extends CharacterBody2D

signal primary_attack(pos, direction)

@export var max_speed: int = 250
var speed: int = max_speed
var facing = Vector2(0, 0)
var equipped_item: Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	equipped_item = load("res://scenes/equipment/keyboard.tscn").instantiate()
	$HandsCenter.add_child(equipped_item)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction != Vector2(0, 0):
		facing = direction
	velocity = direction * speed
	#Set raycast to direction faced and get first object found
	$RayCast2D.target_position = facing * 25
	var thing_in_front = $RayCast2D.get_collider()
	
	if get_global_mouse_position().x < global_position.x:
		$HandsCenter.scale = Vector2(1, -1)
	else:
		$HandsCenter.scale = Vector2(1, 1)
	$HandsCenter.look_at(get_global_mouse_position())
	
	move_and_slide()
	
	# HANDLE INPUT
	#---Set animation based on moevement
	if Input.is_action_pressed("up"):
		$PlayerImg.play("move_up")
	elif Input.is_action_pressed("down"):
		$PlayerImg.play("move_down")
	elif Input.is_action_pressed("right"):
		$PlayerImg.play("move_right")
	elif Input.is_action_pressed("left"):
		$PlayerImg.play("move_left")
	else:
		$PlayerImg.stop()
		
	#---Handle Action Inputs
	if Input.is_action_just_pressed("primary action"):
		#TODO Restructure attacks, make hitbox linked to equipped_item
		# Get Hitbox node from equipped_item node
		# send that node to the signal
		# World instat
		var attack_face = $HandsCenter.rotation_degrees
		var attack_face_node = equipped_item.primary(attack_face)
		primary_attack.emit(attack_face_node)
		print("Primary Action")

	if Input.is_action_just_pressed("secondary action"):
		print("Secondary Action!")
		
	if Input.is_action_just_pressed("Interact"):
		if %DialogPopup.visible:
			%DialogPopup.advance_dialogue()
		elif thing_in_front != null:
			if thing_in_front.is_in_group("NPC"):
				thing_in_front.interact($".")

