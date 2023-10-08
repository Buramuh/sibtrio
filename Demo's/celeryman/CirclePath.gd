extends Path2D

var SCREEN_WIDTH = 1920
var SCREEN_HEIGHT = 1080

var ORIGIN_X = SCREEN_WIDTH/2
var ORIGIN_Y = SCREEN_HEIGHT/2
var ORIGIN = Vector2(ORIGIN_X, ORIGIN_Y)

var RAD_HOR = 400
var RAD_VER = 400

var POINTS = 32


# Called when the node enters the scene tree for the first time.
func _ready():
	curve = Curve2D.new()
	
	for i in range(0, POINTS+1):
		var angle = float(i) / POINTS * TAU
		curve.add_point(Vector2(cos(angle) * RAD_HOR, sin(angle) * RAD_VER) + ORIGIN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
