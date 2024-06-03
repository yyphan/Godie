extends CharacterBody2D

class_name Wolf
@export var towards :bool = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(position.x)
	velocity.x = $EnemyMovementController.handle_running(delta, is_on_floor())
	towards = velocity.x>0
	move_and_slide()
	
