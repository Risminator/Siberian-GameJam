extends Node2D
class_name Hero

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func attack() -> void:
	animation_player.play("attack")

func deal_damage() -> void:
	Events.hero_attack.emit()

func go_home() -> void:
	animation_player.play("go_home")
	
func return_to_tavern() -> void:
	Global.reset_happiness()
	SceneChanger.change_to(Global.GAME_SCENES.TAVERN)
