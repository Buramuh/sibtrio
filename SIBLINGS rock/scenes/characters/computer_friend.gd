extends NpcScene
var speeches = ["Beep", "Boop", "EAT ME"]
var times_spoken = 0


func interact(player):
	var dialog_popup = player.find_child("DialogPopup")
	dialog_popup.speaker_set("Computer Friend")
	dialog_popup.visible = !dialog_popup.visible
	print(dialog_popup)
	dialog_popup.content_set(speeches[times_spoken%3])
	times_spoken += 1
