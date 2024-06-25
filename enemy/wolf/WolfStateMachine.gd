extends Node

@export var inital_state:State  #初始状态
var current_state:State  #当前状态

var states:Dictionary={}  #状态字典

func _ready():
	#完成状态字典数据
	for child in get_children():
		if child is State:
			states[child.name.to_lower()]= child
			child.Transitioned.connect(on_child_transition)  #连接信号到本页脚本
	#设置初始状态
	if inital_state:
		inital_state.Enter() #调用状态进入函数
		current_state = inital_state
	pass 


func _process(delta):
	#调用当前状态更新函数
	if current_state:
		current_state.Update(delta)
		
func _physics_process(delta):
	#调用当前状态物理更新函数
	if current_state:
		current_state.Physics_Update(delta)

#状态改变信号调用函数，第一个参数表示目前处于状态，也就是进入新的状态有哪个状态发起的；第二个参数表示要进行新状态的名称
func on_child_transition(state,new_state_name):
	#如果传入的状态部署当前状态，退出信号
	if state!=current_state:
		return
	#根据状态名称调出状态数据字典中对应的状态
	var new_state = states.get(new_state_name.to_lower())
	#如果状态数据字典中不存在对应的状态退出
	if !new_state:
		return
	#退出当前状态，调用状态退出函数
	if current_state:
		current_state.Exit()
	#进入新的状态，调用进入函数
	new_state.Enter()
	#将当前状态设置为新的状态
	current_state = new_state	
	
func is_state(state):
	return current_state.name == state

