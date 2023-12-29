extends CharacterBody2D
class_name NpcScene

#@onready var dialog_popup = get_tree().root.get_node("World/Player/DialogPopup")

func interact(player):
	print('Generic Interaction Started')
