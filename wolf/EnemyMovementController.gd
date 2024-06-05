extends Node
class_name EnemyMovementController
@onready var wolf: Wolf = get_owner()
@onready var player : Player = get_node("/root/Main/Player")
@export var _speed: float = randf_range(20,30)
## Set to true to ignore accelerations and always move at Max Speed
var direction: bool
enum {
	IDLE,
	WANDER,
	CHASE,
	ATTACK,
	HURT,
	DEATH
}
@export var state = IDLE
const SPEED = 30.0
func handle_action(delta_time: float, is_on_floor: bool):
	match state:
			IDLE:
				wolf.velocity.x=0
			WANDER:
				wolf.velocity.x=_speed
			#处理wandering边界，距离足够就开始追击player
			CHASE:
				print("entering chasing boundary")
				#wolf.position = wolf.position.move_toward(player.position,SPEED)
				wolf.velocity.x = sign(player.position.x - wolf.position.x) * SPEED

#func handle_running(delta_time: float, is_on_ground: bool) :
	##处理wandering边界，距离足够就开始追击player
	#if state == CHASE:
		#print("entering chasing boundary")
		#return sign(player.position.x-wolf.position.x)*50
	##距离不足够，根据timer变化速度，随即传参
	#elif state: 
		#return _speed


func _on_trace_area_body_entered(body):
	if body.name=="Player" :
		print("detect player",wolf.velocity.x)
		state = CHASE


func _on_trace_area_body_exited(body):
	if body.name=="Player" :
		print("player out")
		state = IDLE


func _on_timer_timeout():
	_speed=sign(randi_range(-1, 1))*randf_range(20,30)
	if(_speed != 0 && state != CHASE):
		state = WANDER
	else:
		state = IDLE
		
