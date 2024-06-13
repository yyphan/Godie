extends CharacterBody2D

class_name Player


func _physics_process(delta):
	velocity.x = $MovementController.handle_running(delta, velocity.x, is_on_floor())
	velocity.y = $JumpController.handle_jumping(delta, velocity.y, is_on_floor())

	move_and_slide()
