extends State
class_name EnemyAttack

@export var enemy: CharacterBody2D

var player: CharacterBody2D

func Enter():
	print("进入Attack")
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta: float):
	enemy.velocity.x = 0
