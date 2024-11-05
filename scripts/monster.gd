extends Node2D
class_name Monster

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var damage: int = 20


func die() -> void:
	animation_player.play("die")

func attack() -> void:
	animation_player.play("attack")

func deal_damage() -> void:
	Global.alter_happiness_by(-damage)
	Events.monster_attack.emit()

func finally_disappear() -> void:
	Events.monster_dead.emit()
	queue_free()
