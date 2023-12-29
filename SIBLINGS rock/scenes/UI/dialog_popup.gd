extends CanvasLayer

#gets the values of our npc from our NPC scene and sets it in the label values
var npc_name : String = "npc_name_set"
var message: String = "message_set"
var response: String = "response_set"

var cached_text: Array
var text_pointer: int = 0

#reference to NPC
var npc

func dialogue(speaker, messages):
	set_speaker(speaker)
	set_content(messages[0])
	cached_text = messages
	text_pointer = 0
	visible = true
	
func advance_dialogue():
	text_pointer += 1	
	if text_pointer >= cached_text.size():
		visible = false
		text_pointer = 0
		cached_text = []
	else:
		set_content(cached_text[text_pointer])

#sets the npc name with the value received from NPC
func set_speaker(new_value):
	npc_name = new_value
	$ColorRect/Speaker.text = new_value

#sets the message with the value received from NPC
func set_content(new_value):
	message = new_value
	$ColorRect/Content.text = new_value
	
#sets the response with the value received from NPC
func set_reply(new_value):
	response = new_value
	$ColorRect/Replies/Reply.text = new_value
