extends Camera2D


@onready var player : Player = get_parent().get_node("Player")

@export_range(0.0, 5.0, 0.1) var _zoom_level := 1.5
@export_range(0, 200, 2) var _look_ahead := 100
@export_range(-50, 50, 2) var _offset_y := 0


func _ready():
	set_zoom(Vector2(_zoom_level, _zoom_level))


func _process(delta):
	var lookingDir = -1 if player.get_node("AnimatedSprite2D").flip_h else 1
	set_position(Vector2(player.get_position().x + _look_ahead * lookingDir, player.get_position().y + _offset_y))
