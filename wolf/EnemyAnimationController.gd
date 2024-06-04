extends Node
class_name EnemyAnimationController
@onready var wolf: Wolf = get_owner()
@onready var player : Player = get_owner().get_parent().get_node("Player")
	
func is_wandering() -> bool:
	#当玩家敌人距离不够时，敌人闲逛
	return abs(player.position.x-wolf.position.x) < 150
	
func is_running() -> bool:
	return wolf.velocity.x != 0
	
func is_idling() -> bool:
	return wolf.velocity.x == 0

func is_attacking() -> bool:
	return wolf.is_collided




