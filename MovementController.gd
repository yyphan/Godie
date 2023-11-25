extends Node


@export var _max_speed: int = 100
## Set to true to ignore accelerations and always move at Max Speed
@export var _is_instant_movement: bool = false;

@export var _acceleration: int = 70
@export var _midair_acceleration: int = 70

## The rate the velocity decelerates to 0 when no input present (on ground)
@export var _deceleration: int = 70 
## The rate the velocity decelerates to 0 when no input present (mid air)
@export var _midair_deceleration: int = 70

## The rate the velocity decelerates and/or flips when input is opposite to current velocity (on ground)
@export var _turn_speed: int = 70; 
## The rate the velocity decelerates and/or flips when input is opposite to current velocity (mid air)
@export var _midair_turn_speed: int = 70; 


# Get horizontal input direction and return velocity after acceleration/turn/deceleration.
func handle_running(delta_time: float, current_velocity_x: float, is_on_ground: bool) -> float:
	var direction: float = Input.get_axis("move_left", "move_right")  # ranges between -1 and 1
	if _is_instant_movement:
		return direction * _max_speed
		
	var acceleration: int = _acceleration if is_on_ground else _midair_acceleration
	var deceleration: int = _deceleration if is_on_ground else _midair_deceleration
	var turn_speed: int = _turn_speed if is_on_ground else _midair_turn_speed
	
	var target_velocity_x: int = sign(direction) * _max_speed
	var delta_speed: float
	if direction != 0:
		if sign(direction) == sign(current_velocity_x):  # accelerating
			delta_speed = acceleration * delta_time
		else:  # turning
			delta_speed = turn_speed * delta_time
	else:  # deceleration
		delta_speed = deceleration * delta_time
		
	return move_toward(current_velocity_x, target_velocity_x, delta_speed)
