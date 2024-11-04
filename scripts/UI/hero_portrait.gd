extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = true
	Events.minigame_chosen.connect(_on_minigame_chosen)
	Events.return_to_tavern.connect(_on_return_to_tavern)
	
func _on_minigame_chosen(minigame: Global.MINI_GAMES) -> void:
	visible = false
	
func _on_return_to_tavern(minigame: Global.MINI_GAMES) -> void:
	visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
