extends Node

@onready var player: Player = get_owner()

enum PLAYER_ANIM_STATE {IDLE, ATTACK, SHIELD, HURT, RUN}
var _cur_state: PLAYER_ANIM_STATE = PLAYER_ANIM_STATE.IDLE

func set_state(new_state: PLAYER_ANIM_STATE):
	_cur_state = new_state

func is_running() -> bool:
	return _cur_state == PLAYER_ANIM_STATE.RUN
	
func is_hurting() -> bool:
	return _cur_state == PLAYER_ANIM_STATE.HURT
	
func is_holding_shield() -> bool:
	return _cur_state == PLAYER_ANIM_STATE.SHIELD

func is_attacking() -> bool:
	return _cur_state == PLAYER_ANIM_STATE.ATTACK
