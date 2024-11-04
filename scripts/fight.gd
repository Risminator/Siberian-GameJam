extends Node2D

@onready var hero: Sprite2D = $Hero
@onready var monsters: Node2D = $Monsters


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fight_round_ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	fight_round_process()


func fight_round_ready() -> void:
	pass
	
func fight_round_process() -> void:
	pass
