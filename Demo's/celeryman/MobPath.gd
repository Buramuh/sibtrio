extends Path2D

var SIZE = 500
var ORIGIN_X = 1920/2
var ORIGIN_Y = 1080/2
var NUM_POINTS = 32

# Called when the node enters the scene tree for the first time.
func _ready():
	curve = Curve2D.new()
	for i in NUM_POINTS:
		curve.add_point(Vector2(0, -SIZE).rotated((i / float(NUM_POINTS)) * TAU) + Vector2(ORIGIN_X, ORIGIN_Y))

	# End the circle.
	curve.add_point(Vector2(0, -SIZE) + Vector2(ORIGIN_X, ORIGIN_Y))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
