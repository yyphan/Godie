extends Timer


# Called when the node enters the scene tree for the first time.

func _ready():
	connect("timeout",Callable(self,"_on_timeout"))

func _on_timeout():
	#提供速度和方向的更改，2秒一次，sign提供方向，randf提供速度变化范围
	get_parent()._speed=sign(randi_range(-100, 100))*randf_range(20,30)
