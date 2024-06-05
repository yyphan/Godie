extends Node2D
var wolf_preload = preload("res://wolf/Wolf.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func wolf_spawn():
	var wolf = wolf_preload.instantiate()
	wolf.position = Vector2(randi_range(30,100),randi_range(-50,0))
	$Wolf.add_child(wolf)

func _on_timer_timeout():
	wolf_spawn()


