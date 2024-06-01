extends Camera2D


@onready var player : Player = get_parent().get_node("Player")

## 调整镜头的远近
@export_range(0.0, 5.0, 0.1) var _zoom_level := 1.5
## 调整镜头在玩家前方的距离(提前看到前面的东西）
@export_range(0, 200, 2) var _look_ahead := 100
## 调整镜头在玩家y轴上的偏移（锁定在玩家上方或下方）
@export_range(-50, 50, 2) var _offset_y := 0
## 调整镜头在x轴上移动时速度的渐变（0为纯匀速，数值越大镜头移动时减速减的最多）
@export_range(0, 0.5, 0.1) var _linear_damping_x := 0.1
## 调整镜头在y轴上移动时速度的渐变（0为纯匀速，数值越大镜头移动时减速减的最多）
@export_range(0, 0.5, 0.1) var _linear_damping_y := 0.1
## 调整镜头移动的速度，1是原速
@export_range(1, 5, 0.5) var _move_speed_scale := 2


func _ready():
	set_zoom(Vector2(_zoom_level, _zoom_level))


func _process(delta):
	var looking_dir = -1 if player.get_node("PlayerSprite").flip_h else 1
	var target_x: float = player.get_position().x + _look_ahead * looking_dir
	var target_y: float = player.get_position().y + _offset_y
	var camera_moving_vector = Vector2(target_x, target_y) - get_position()
	var damped_camera_moving_vector = Vector2(
		camera_moving_vector.x * (1.0 - _linear_damping_x), 
		camera_moving_vector.y * (1.0 - _linear_damping_y)
	)
	set_position(get_position() + damped_camera_moving_vector * delta * _move_speed_scale)
	
