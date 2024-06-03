extends Node

@onready var wolf: Wolf = get_owner()
@onready var player : Player = get_owner().get_parent().get_node("Player")
@export var _speed: int = sign(randi_range(-1,1))*30
## Set to true to ignore accelerations and always move at Max Speed
var direction: bool

func handle_running(delta_time: float, is_on_ground: bool) :
	if abs(player.position.x-wolf.position.x) < 150:
		return sign(player.position.x-wolf.position.x)*_speed
	#处理wandering边界，距离足够就开始追击player
	else: 
		return _speed

	

