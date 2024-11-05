extends Node2D
class_name Hero

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _ready():
	Events.game_win.connect(_on_game_win)

func attack() -> void:
	animation_player.play("attack")

func deal_damage() -> void:
	Events.hero_attack.emit()

func go_home() -> void:
	animation_player.play("go_home")
	
func return_to_tavern() -> void:
	Global.reset_happiness()
	SceneChanger.change_to(Global.GAME_SCENES.TAVERN)

func _on_game_win() -> void:
	sprite_2d.play("5")
