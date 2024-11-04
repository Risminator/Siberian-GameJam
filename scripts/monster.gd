extends Node2D
class_name Monster

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var damage: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
