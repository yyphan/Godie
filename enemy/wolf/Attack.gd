extends State
class_name Attack

@export var enemy: CharacterBody2D

var player: CharacterBody2D

func Enter():
	print("进入Attack状态")

func Physics_Update(delta: float):
	enemy.velocity.x = 0
	pass


func _on_enemy_animation_tree_animation_finished(Attack):
	print("结束攻击动作")
	Transitioned.emit(self,"Idle")


func _on_hurt_area_area_entered(area):
	print("由攻击状态进入受击状态")
	Transitioned.emit(self,"Hurt")
