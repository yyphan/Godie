extends State
class_name EnemyChase

@export var enemy: CharacterBody2D
@export var move_speed := 40.0

var player: CharacterBody2D

func Enter():
	print("进入Chase")
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta: float):
	enemy.velocity.x = sign(player.position.x - enemy.position.x) * move_speed
