extends Node2D
class_name MiniGame

var is_game_active:bool = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var button: Button = $CanvasLayer/Button
@export var happiness_reward: int = 25

@export var current_minigame: Global.MINI_GAMES

@onready var win_sfx: AudioStreamPlayer = $WinSFX
@onready var instruction_animation_player: AnimationPlayer = $CanvasLayer/InstructionLabel/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.minigame_completed.connect(_on_minigame_completed)
	Events.go_to_battle.connect(minigame_exit)
	instruction_animation_player.play("appear")
	minigame_ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	minigame_process(delta)

func _on_minigame_completed() -> void:
	win_sfx.play()
	Global.alter_happiness_by(happiness_reward)
	if Global.HappinessValue < Global.MAX_HAPPINESS:
		set_return_button_active()

func minigame_ready() -> void:
	pass

func minigame_process(_delta: float) -> void:
	pass

func minigame_exit() -> void:
	pass

func start() -> void:
	is_game_active = true
	minigame_start()

func minigame_start() -> void:
	pass

func set_return_button_active():
	button.visible = true


func _on_button_pressed() -> void:
	minigame_exit()
	Events.return_to_tavern.emit(current_minigame)
	animation_player.play("exit")
