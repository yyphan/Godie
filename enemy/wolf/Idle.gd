extends State #继承基本状态类
class_name Idle #类名称

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")
@export var enemy: CharacterBody2D #敌人，出现在该类的检查器，可拖入敌人的CharacterBody2D对象
@export var move_speed := 0 #敌人移动速度，出现在该类的检查器

var move_direction : float
var wander_time : float


func randomize_wander():
	move_direction = randi_range(-1,1)
	move_speed = randf_range(20,30)
	wander_time = randf_range(1,3)

func Enter():
	print("进入Idle状态")
	randomize_wander()
	
func Update(delta: float):
	if(wander_time > 0):
		wander_time -= delta
	
	else:
		randomize_wander()

func Physics_Update(delta: float):
	#判断是否在攻击区域
	var AttackA: Area2D = enemy.get_node("AttackArea")
	if AttackA.overlaps_body(player):
		print("在攻击范围！！！")
		Transitioned.emit(self,"Attack")
	#判断是否在追逐区域
	var TraceA: Area2D = enemy.get_node("TraceArea")
	if TraceA.overlaps_body(player):
		print("在追逐范围！！！")
		Transitioned.emit(self,"Chase")
		
	if enemy: #初始状态，需判断enemy是否为空
		enemy.velocity.x = move_direction * move_speed

