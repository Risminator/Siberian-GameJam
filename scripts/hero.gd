extends Node2D
class_name Hero

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func attack() -> void:
	animation_player.play("attack")

func deal_damage() -> void:
	Events.hero_attack.emit()
