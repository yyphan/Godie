extends State
class_name Hurt

@export var enemy: CharacterBody2D

var player: CharacterBody2D


func Enter():
	print("进入Hurt状态")
	
func Physics_Update(delta: float):
	enemy.velocity.x = 30
	pass


func _on_enemy_animation_tree_animation_finished(Hurt):
	print("结束受伤动作")
	Transitioned.emit(self,"Idle")

