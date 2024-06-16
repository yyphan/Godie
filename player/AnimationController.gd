extends Node

@onready var player: Player = get_owner()

func is_running() -> bool:
	return player.velocity.x != 0
	
func is_hurting() -> bool:
	return player.is_hurt_state

func is_attack_just_pressed() -> bool:
	return Input.is_action_just_pressed("attack")


func is_shield_just_pressed() -> bool:
	return Input.is_action_just_pressed("shield")
	
	
func is_shield_just_released() -> bool:
	return Input.is_action_just_released("shield")


