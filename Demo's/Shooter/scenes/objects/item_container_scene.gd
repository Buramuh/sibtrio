extends StaticBody2D
class_name ItemContainerScene

var opened: bool = false

signal open(pos, direction)


@onready var current_direction: Vector2 = Vector2.DOWN.rotated(rotation)

