extends Node
class_name EnemyAnimationController
@onready var wolf: Wolf = get_owner()
@onready var moveCtrl: EnemyMovementController = get_owner().get_node("EnemyMovementController")
enum {
	IDLE,
	WANDER,
	CHASE,
	ATTACK,
	HURT,
	DEATH
}
func is_idling() -> bool:
	return  moveCtrl.state == IDLE
	
func is_running() -> bool:
	#对于动画来说，wander和chase是一样的
	return  moveCtrl.state == WANDER || moveCtrl.state == CHASE
	
func is_attacking() -> bool:
	return moveCtrl.state == ATTACK
#func is_hurting() -> bool:
	#return  moveC.state == HURT
	#
#func is_deathing() -> bool:
	#return  moveC.state == DEATH
	


