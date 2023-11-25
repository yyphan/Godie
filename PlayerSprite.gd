extends AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("move_left"):
		flip_h = true;
	elif Input.is_action_just_pressed("move_right"):
		flip_h = false;
