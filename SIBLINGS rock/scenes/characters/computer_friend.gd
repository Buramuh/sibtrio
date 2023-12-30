extends NpcScene
var speeches = [["Beep", "Boop"], ["Im a Computer"], ["EAT ME"]]
var times_spoken = 0
@export var name_text = "Computer Friend"


func interact(player):
	var dialog_popup = player.find_child("DialogPopup")
	dialog_popup.dialogue(name_text, speeches[times_spoken%3])
	times_spoken += 1
