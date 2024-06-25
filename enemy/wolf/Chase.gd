extends State
class_name Chase

@export var enemy: CharacterBody2D
@export var move_speed := 40.0

var player: CharacterBody2D

func Enter():
	print("进入Chase状态")
	player = get_tree().get_first_node_in_group("Player")

func Physics_Update(delta: float):
	#判断是否在追逐区域
	var TraceA: Area2D = enemy.get_node("TraceArea")
	if !TraceA.overlaps_body(player):
		print("脱离追逐范围！！！")
		Transitioned.emit(self,"Idle")
	#判断是否在攻击区域
	var AttackA: Area2D = enemy.get_node("AttackArea")	
	if AttackA.overlaps_body(player):
		print("在攻击范围！！！")
		Transitioned.emit(self,"Attack")
		
	enemy.velocity.x = sign(player.position.x - enemy.position.x) * move_speed


func _on_hurt_area_area_entered(area):
	print("由追击状态进入受击状态")
	Transitioned.emit(self,"Hurt")
