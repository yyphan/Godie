extends CharacterBody2D

class_name Player
@export var knockback_speed := 150
var _base_gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

enum PLAYER_STATE {IDLE, ATTACK, SHIELD, HURT, RUN}
var _cur_state: PLAYER_STATE = PLAYER_STATE.IDLE

func _physics_process(delta):
	_handle_input()
	
	if (_can_move()):
		velocity.x = $MovementController.handle_running(delta, velocity.x, is_on_floor())
		if (velocity.x != 0):
			set_state(PLAYER_STATE.RUN)
		else:
			set_state(PLAYER_STATE.IDLE)
		
	if (_can_jump()):
		velocity.y = $JumpController.handle_jumping(delta, velocity.y, is_on_floor())
		
	move_and_slide()

	
func set_state(new_state: PLAYER_STATE):
	if (_cur_state == new_state):
		return
	
	match(new_state):
		PLAYER_STATE.IDLE:
			_cur_state = new_state
			$AnimationController.set_state($AnimationController.PLAYER_ANIM_STATE.IDLE)
		PLAYER_STATE.RUN:
			_cur_state = new_state
			$AnimationController.set_state($AnimationController.PLAYER_ANIM_STATE.RUN)
		PLAYER_STATE.ATTACK:
			_cur_state = new_state
			velocity = Vector2.ZERO
			$AnimationController.set_state($AnimationController.PLAYER_ANIM_STATE.ATTACK)
		PLAYER_STATE.SHIELD:
			_cur_state = new_state
			velocity = Vector2.ZERO
			$AnimationController.set_state($AnimationController.PLAYER_ANIM_STATE.SHIELD)
		PLAYER_STATE.HURT:
			_cur_state = new_state
			velocity = Vector2.ZERO
			$AnimationController.set_state($AnimationController.PLAYER_ANIM_STATE.HURT)


func _handle_input():
	if (_cur_state == PLAYER_STATE.HURT):
		return;
	
	if (Input.is_action_just_pressed("attack")):
		set_state(PLAYER_STATE.ATTACK)
	elif (Input.is_action_just_pressed("shield")):
		set_state(PLAYER_STATE.SHIELD)	
	elif (Input.is_action_just_released("shield")):
		set_state(PLAYER_STATE.IDLE)	


func _can_move() -> bool:
	return _cur_state != PLAYER_STATE.HURT && _cur_state != PLAYER_STATE.SHIELD && _cur_state != PLAYER_STATE.ATTACK


func _can_jump() -> bool:
	return _cur_state != PLAYER_STATE.HURT && _cur_state != PLAYER_STATE.ATTACK


func _on_hurt_area_area_entered(area):
	if(area.get_owner().position.x > self.position.x):
		velocity -= Vector2(1,0.5) * knockback_speed
	else:
		velocity -= Vector2(-1,0.5) * knockback_speed
	print("受伤啦")
	set_state(PLAYER_STATE.HURT)
