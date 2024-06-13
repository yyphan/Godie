extends AnimatedSprite2D
@onready var wolf: Wolf = get_owner()
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var wolfA: EnemyAnimationController = get_owner().get_node("EnemyAnimationController")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#if(wolfA.is_running()):
		##根据位移方向决定towards
		#flip_h = wolf.velocity.x < 0;
	#else:
		##攻击状态
		#flip_h = (wolf.position.x - player.position.x) > 0
	pass

