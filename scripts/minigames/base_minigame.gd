extends Node2D
class_name MiniGame

var is_game_active:bool = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@export var happiness_reward: int = 25

@onready var win_sfx: AudioStreamPlayer = $WinSFX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.minigame_completed.connect(_on_minigame_completed)
	Events.go_to_battle.connect(minigame_exit)
	minigame_ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	minigame_process(delta)

func _on_minigame_completed() -> void:
	win_sfx.play()
	Global.alter_happiness_by(happiness_reward)
	set_return_button_active()

func minigame_ready() -> void:
	pass

func minigame_process(_delta: float) -> void:
	pass

func minigame_exit() -> void:
	pass

func start() -> void:
	is_game_active = true

func set_return_button_active():
	canvas_layer.visible = true


func _on_button_pressed() -> void:
	minigame_exit()
	Events.return_to_tavern.emit(Global.MINI_GAMES.HAIRCUT)
	animation_player.play("exit")
