extends MiniGame

var scissors_cursor = load("res://assets/temp/scissors.png")
var beard_count:int

func minigame_ready() -> void:
	Input.set_custom_mouse_cursor(scissors_cursor)
	beard_count = get_tree().get_nodes_in_group("beard").size()
	Events.beard_cut.connect(_on_beard_cut)


func minigame_exit() -> void:
	Input.set_custom_mouse_cursor(null)
	

func _on_beard_cut() -> void:
	beard_count -= 1
	if beard_count <= 0:
		Events.minigame_completed.emit()
