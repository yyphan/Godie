extends Node

@onready var wolf: Wolf = get_owner()
@onready var player : Player = get_owner().get_parent().get_node("Player")
#_speed为敌人实时速度
@export var _speed: float = randf_range(20,30)
## Set to true to ignore accelerations and always move at Max Speed
var direction: bool

func handle_running(delta_time: float, is_on_ground: bool) :
	#处理wandering边界，距离足够就开始追击player
	if abs(player.position.x-wolf.position.x) < 150:
		return sign(player.position.x-wolf.position.x)*50
	#距离不足够，根据timer变化速度，随即传参
	else: 
		return _speed

	

