extends CanvasLayer

@onready var timer = $LetterDisplayTimer

signal finished_displaying()

var text = "It's locked.."
var letter_index = 0

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2



func _ready():
	pass



func _process(delta):
	pass

func _display_letter():
	$Dialog.text += text [letter_index]
	letter_index += 1
	
	if letter_index >= text.length():
		finished_displaying.emit()
	
	match text[letter_index]:
		"!", ".", ",", "?":
			$PunctuationTime.start()
		" ":
			$SpaceTime.start()
		_:
			$LetterTime.start()


func _on_letter_display_timer_timeout():
	_display_letter()
