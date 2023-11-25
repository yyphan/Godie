extends CharacterBody2D

class_name Player

@export_group("Running")
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


@export_group("Jumping")
@export var _jump_height: float = 100
## Scales the gravity when going up (in the jump), e.g. set to 2 would be two times the normal gravity
@export var _upward_gravity_multiplier: float = 1
## Scales the gravity when falling down (in the jump), e.g. set to 2 would be two times the normal gravity
@export var _downward_gravity_multiplier: float = 1
## Coyote time allows character to perform the jump within some time after falling off platform
@export var _coyote_time_seconds: float = 0.2
## Jump buffer acknoledges the last jump input that is hit within some time before chracter falls to ground
@export var _jump_buffer_seconds: float = 0.1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var _base_gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
# Coyote time starts counting when character falls off a platform
var _coyote_time_counter: float = 0
var _is_jumping = false
# Jump buffer starts counting when player hits jump but chracter is still mid air
var _is_jump_buffer_counting = false
var _jump_buffer_counter: float = 0
# Performs a jump whenever this boolean is true (doesn't have to be synced with jump input)
var _desire_jump = false  

func _physics_process(delta):
	velocity.x = handle_running(delta, velocity.x, is_on_floor())
	velocity.y = handle_jumping(delta, velocity.y, is_on_floor())
	velocity.y = apply_gravity(delta, velocity.y)
	
	move_and_slide()
	
	if velocity.x != 0:
		$AnimatedSprite2D.play("Run")
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif Input.is_action_pressed("shield"):
		$AnimatedSprite2D.play("Shield")
	else :
		$AnimatedSprite2D.play("Idle")
	
	
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


# Get jump input and update vertical velocity 
func handle_jumping(delta_time: float, current_velocity_y: float, is_on_ground: bool) -> float:
	handle_coyote_time_counting(delta_time, is_on_ground)
	handle_jump_buffer_counting(delta_time, is_on_ground)
		
	if Input.is_action_just_pressed("jump"):
		if is_on_ground:
			_desire_jump = true
		elif can_cayote_jump():
			_desire_jump = true
		else:  # start counting jump buffer
			_jump_buffer_counter = 0
			_is_jump_buffer_counting = true
	
	if _desire_jump:  
		_desire_jump = false
		_is_jumping = true
		var jump_force: float = sqrt(2 * _jump_height * calculate_gravity(current_velocity_y))
		# Make jump during coyote time (mid air) feels just as strong as jumping from the ground
		if current_velocity_y > 0:  
			jump_force += current_velocity_y
		current_velocity_y -= jump_force
		
	return current_velocity_y


func apply_gravity(delta_time: float, current_velocity_y: float) -> float:
	var cur_gravity: float = calculate_gravity(current_velocity_y)
	return current_velocity_y + cur_gravity * delta_time


# Adjust gravity when jumping up and falling down
func calculate_gravity(current_velocity_y: float):
	if current_velocity_y > 0.01:  # falling down
		return _base_gravity * _downward_gravity_multiplier
	else:  # jumping up
		return _base_gravity * _upward_gravity_multiplier


# Can jump after just falling off platform 
func can_cayote_jump() -> bool:
	return _coyote_time_counter < _coyote_time_seconds and !_is_jumping


func handle_coyote_time_counting(delta_time: float, is_on_ground: bool):
	if is_on_ground:
		_is_jumping = false
		_coyote_time_counter = 0
	elif _coyote_time_counter < _coyote_time_seconds + delta_time:
		_coyote_time_counter += delta_time


func handle_jump_buffer_counting(delta_time: float, is_on_ground: bool):
	if is_on_ground:
		# Player pressed jump within the buffer time. Now character has landed, signal to perform the jump
		if _is_jump_buffer_counting && _jump_buffer_counter < _jump_buffer_seconds:  
			_desire_jump = true
		_is_jump_buffer_counting = false
	elif _is_jump_buffer_counting && _jump_buffer_counter < _jump_buffer_seconds + delta_time:
		_jump_buffer_counter += delta_time
