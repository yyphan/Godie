extends Node
class_name EnemyAnimationController
@onready var wolf: Wolf = get_owner()
@onready var player : Player = get_owner().get_parent().get_node("Player")
@onready var moveC: EnemyMovementController = get_owner().get_node("EnemyMovementController")
enum {
	IDLE,
	WANDER,
	CHASE,
	ATTACK,
	HURT,
	DEATH
}
func is_idling() -> bool:
	#return  moveC.state == IDLE
	return  wolf.velocity.x == 0
	#
func is_running() -> bool:
	#对于动画来说，wander和chase是一样的
	return moveC.state == WANDER || moveC.state == CHASE
	
#func is_attacking() -> bool:
	#return  moveC.state == ATTACK
	#
#func is_hurting() -> bool:
	#return  moveC.state == HURT
	#
#func is_deathing() -> bool:
	#return  moveC.state == DEATH
	


