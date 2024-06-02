extends AnimatedSprite2D

@onready var wolf: Wolf = get_owner()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if wolf.get_node("EnemyAnimationController").is_wandering():
		flip_h = true;
	else :
		flip_h = false;
