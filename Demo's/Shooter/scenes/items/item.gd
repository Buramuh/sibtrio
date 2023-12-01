extends Area2D
var rotation_speed: int = 4
var type_options = ['laser', 'laser', 'laser', 'laser', 'grenade', 'health']
var type = type_options[randi()%len(type_options)]
#var type = 'health'

func _ready():
	if type == 'laser':
		$Sprite2D.modulate = Color(0.1,0.1,6)
	if type == 'grenade':
		$Sprite2D.modulate = Color(0.8,0.1,0.1)	
	if type == 'health':
		$Sprite2D.modulate = Color(0.1,0.8,0.1)
		
func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(_body):
	if type == 'health':
		Globals.health += 10
	if type == 'laser':
		Globals.laser_amount += 5
	if type == 'grenade':
		Globals.grenade_amount += 1
	queue_free()
