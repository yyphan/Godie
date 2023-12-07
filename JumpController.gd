extends Node


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
		
	current_velocity_y = apply_gravity(delta_time, current_velocity_y)
	
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
