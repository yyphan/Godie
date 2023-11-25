extends Camera2D


@onready var player : Player = get_parent().get_node("Player")


func _process(delta):
	position = player.position
