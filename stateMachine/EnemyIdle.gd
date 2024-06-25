extends State #继承基本状态类
class_name EnemyIdle #类名称

@export var enemy: CharacterBody2D #敌人，出现在该类的检查器，可拖入敌人的CharacterBody2D对象
@export var move_speed := 30 #敌人移动速度，出现在该类的检查器

var move_direction : float
var wander_time : float

func randomize_wander():
	move_direction = randi_range(-1,1)
	move_speed = randf_range(20,30)
	wander_time = randf_range(1,3)

func Enter():
	print("进入Idle")
	randomize_wander()
	
func Update(delta: float):
	if(wander_time > 0):
		wander_time -= delta
	
	else:
		randomize_wander()

func Physics_Update(delta: float):
	if enemy:
		enemy.velocity.x = move_direction * move_speed



