extends CharacterBody2D

func _physics_process(delta):
	velocity.x = $MovementController.handle_running(delta, velocity.x, is_on_floor())
	velocity.y = $JumpController.handle_jumping(delta, velocity.y, is_on_floor())
	
	move_and_slide()
	
	if velocity.x != 0:
		$AnimatedSprite2D.play("Run")
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif Input.is_action_pressed("shield"):
		$AnimatedSprite2D.play("Shield")
	else :
		$AnimatedSprite2D.play("Idle")


