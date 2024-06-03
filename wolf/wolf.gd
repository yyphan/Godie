extends CharacterBody2D

class_name Wolf
@export var towards :bool = true
# Get the gravity from the project settings to be synced with RigidBody nodes.
var _base_gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = $EnemyMovementController.handle_running(delta, is_on_floor())
	velocity.y += delta * _base_gravity
	towards = velocity.x>0
	print(velocity.x)
	move_and_slide()
	
