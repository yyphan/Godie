extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport = get_viewport()
	viewport.size = Vector2(1920, 1080)


