extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
	if Input.is_action_just_released("lmb"):
		queue_free()
