extends Node
class_name EnemyMovementController
@onready var wolf: Wolf = get_owner()
@onready var player = get_tree().get_first_node_in_group("Player")

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
#初始状态为IDLE
@export var state = IDLE
var wander_time : float = randf_range(1,3)
const SPEED = 30.0
func handle_action(delta_time: float, is_on_floor: bool):
	#print("wander_time: ",wander_time,"wander_speed: ",_speed)
	match state:
			IDLE:
				update(delta_time)
				wolf.velocity.x=0
			WANDER:
				update(delta_time)
				wolf.velocity.x=_speed
			#处理wandering边界，距离足够就开始追击player
			CHASE:
				#wolf.position = wolf.position.move_toward(player.position,SPEED)		TODO: 不能实现，运动快的一匹，不懂为啥
				update(delta_time)
				wolf.velocity.x = sign(player.position.x - wolf.position.x) * SPEED
			ATTACK:
				wolf.velocity.x=0

func randomize_wander():
	_speed=sign(randi_range(-1, 1))*randf_range(20,30)
	wander_time = randf_range(1,3)

func update(delta_time: float):
	if(wander_time>0):
		wander_time -= delta_time
	else:
		randomize_wander()


#func _on_trace_area_body_entered(body):
	#if body.name=="Player" :
		#print("detect player, now wolf v_x: ",wolf.velocity.x)
		#state = CHASE
#
#
#func _on_trace_area_body_exited(body):
	#if body.name=="Player" :
		#print("player out")
		#state = IDLE


#func _on_timer_timeout():
	##2s定时器，判断为WANDER状态后附加速度
	#if(state == WANDER || state == IDLE):
		#_speed=sign(randi_range(-1, 1))*randf_range(20,30)
		##if(_speed == 0):
			##state = IDLE
		###在不为CHASE状态下，判断IDLE or WANDER
		##if(_speed):
			##state = WANDER
		##else:
			##state = IDLE
