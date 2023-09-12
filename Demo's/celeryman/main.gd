extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")

func new_game():
	score = 0
	#$Player.reset_state = true
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_and_hide_message("Get Ready", 2)
	
	
	
func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


var CENTER = Vector2(1920/2, 1080/2)
func calc_direction_to_look_at(target, origin):
	var dx = target.x - origin.x
	var dy = target.y - origin.y
	var direction = atan(dy/dx)
	# atan doesn't know wether the angle needs to point left or right
	# so the angle might need to be inverted, depending on dx
	if dx < 0:
		direction +=  PI
	return direction


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()
	
	if $HUD.physics:
		mob.collision_mask = 1

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position
	
	# Set the mob's direction to look at center
	var direction = calc_direction_to_look_at(CENTER, mob.position)

	# Add some randomness to the direction. -> I tried to make them point to the middle
	direction += randf_range(-PI/8,PI/8)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(300.0, 470.0), 0.0)
	#var velocity = Vector2(randf_range(10.0, 10.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

#Weird Button stuff



func _on_hud_enable_weird():
	var mobs = get_tree().get_nodes_in_group("mobs")
	for mob in mobs:
		mob.collision_mask = 1
	$Player.lock_rotation = false



func _on_hud_disable_weird():
	var mobs = get_tree().get_nodes_in_group("mobs")
	for mob in mobs:
		mob.collision_mask = 0
	$Player.lock_rotation = true
	$Player.start_reset_rotation()
	
	#$Player.set_rot(0)
	#var pos = $Player.position
	#$Player.transform = Transform2D(0,pos)
	
	
	
	
	
