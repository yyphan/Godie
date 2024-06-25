extends CharacterBody2D

class_name Player
@export var knockback_speed := 150
var is_hurt_state : bool = false
var _base_gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if(!is_hurt_state):
		velocity.x = $MovementController.handle_running(delta, velocity.x, is_on_floor())
		velocity.y = $JumpController.handle_jumping(delta, velocity.y, is_on_floor())
	else:
		velocity = velocity.move_toward(Vector2.ZERO, knockback_speed * delta)
		is_hurt_state = false
	move_and_slide()


func _on_hurt_area_area_entered(area):
	if(area.get_owner().position.x > self.position.x):
		velocity -= Vector2(1,0.5) * knockback_speed
	else:
		velocity -= Vector2(-1,0.5) * knockback_speed
	print("受伤啦")
	is_hurt_state = true
