extends Timer


# Called when the node enters the scene tree for the first time.

func _ready():
	connect("timeout",Callable(self,"_on_timeout"))

func _on_timeout():
	print("到时间了")
