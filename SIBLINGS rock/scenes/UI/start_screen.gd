extends Control

const level_0 = "res://scenes/levels/office_0.tscn"

func _process(_delta):
	pass
	


func _on_button_pressed():
	get_tree().change_scene_to_file(level_0)
