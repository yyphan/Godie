extends CharacterBody2D
class_name Wolf
@onready var player = get_tree().get_first_node_in_group("Player")

#is_collided判断玩家敌人是否接触，接触后敌人才判断开始攻击
@export var is_collided: bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var _base_gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#$EnemyMovementController.handle_action(delta, is_on_floor())
	#施加重力
	velocity.y += delta * _base_gravity
	move_and_slide()
	#print($WolfStateMachine.current_state.name)
	if($WolfStateMachine.is_state("Idle")):
		#根据位移方向决定towards
		$WolfSprite.flip_h = self.velocity.x < 0;
	elif($WolfStateMachine.is_state("Attack")):
		#攻击期间不转头
		pass
	elif($WolfStateMachine.is_state("Chase")):
		#追逐期间转头
		$WolfSprite.flip_h = (self.position.x - player.position.x) > 0
		



