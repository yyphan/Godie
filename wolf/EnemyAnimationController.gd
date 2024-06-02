extends Node
class_name EnemyAnimationController
@onready var wolf: Wolf = get_owner()
@onready var player : Player = get_owner().get_parent().get_node("Player")
	
func is_wandering() -> bool:
	return abs(player.position.x-wolf.position.x) < 150
	
func is_running() -> bool:
	return wolf.velocity.x != 0




