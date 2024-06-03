extends AnimatedSprite2D

@onready var wolf: Wolf = get_owner()
@onready var player : Player = get_owner().get_parent().get_node("Player")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		flip_h = !wolf.towards;

