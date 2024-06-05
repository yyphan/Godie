extends CharacterBody2D
class_name Wolf

@onready var player : Player = get_node("/root/Main/Player")

#is_collided判断玩家敌人是否接触，接触后敌人才判断开始攻击
@export var is_collided: bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var _base_gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#velocity.x = $EnemyMovementController.handle_running(delta, is_on_floor())
	$EnemyMovementController.handle_action(delta, is_on_floor())
	#施加重力
	velocity.y += delta * _base_gravity
	move_and_slide()



