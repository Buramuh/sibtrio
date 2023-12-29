extends CanvasLayer

#gets the values of our npc from our NPC scene and sets it in the label values
var npc_name : String = "npc_name_set"
var message: String = "message_set"
var response: String = "response_set"

#reference to NPC
var npc

#sets the npc name with the value received from NPC
func speaker_set(new_value):
	npc_name = new_value
	$ColorRect/Speaker.text = new_value

#sets the message with the value received from NPC
func content_set(new_value):
	message = new_value
	$ColorRect/Content.text = new_value
	
#sets the response with the value received from NPC
func reply_set(new_value):
	response = new_value
	$ColorRect/Replies/Reply.text = new_value
