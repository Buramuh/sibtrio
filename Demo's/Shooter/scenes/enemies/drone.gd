extends CharacterBody2D
var direction
var is_enemy: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2(1, 0)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if position.x > 700:
		direction = Vector2(-1, 0)
	if position.x < 0:
		direction = Vector2(1, 0)
	
	velocity = direction * 200
	move_and_slide()
	
func hit():
	print('damage')
