extends LevelParent
 
@export var outside_level_scene: PackedScene

func _on_exit_gate_area_body_entered(_body):
	print("hh")
	var tween  = create_tween()
	tween.tween_property($Player, "speed",0, 0.25)
	TransitionLayer.change_scene("res://scenes/levels/outside.tscn")
