extends Path2D

var WIDTH = 1920
var HEIGHT = 1080
var ORIGIN_X = WIDTH/2
var ORIGIN_Y = HEIGHT/2
var PAD = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	curve = Curve2D.new()
	
	curve.add_point(Vector2(-PAD		, -PAD		)) # Left-Top
	curve.add_point(Vector2(WIDTH+PAD	, -PAD		)) # Right-Top
	curve.add_point(Vector2(WIDTH+PAD	, HEIGHT+PAD)) # Right-Bottom
	curve.add_point(Vector2(-PAD		, HEIGHT+PAD)) # Left-Bottom
	curve.add_point(Vector2(-PAD		, -PAD		)) # Left-Top


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
