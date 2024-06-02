extends CharacterBody2D

class_name Wolf

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(position.x)
	velocity.x = $EnemyMovementController.handle_running(delta, is_on_floor())
	move_and_slide()
	
