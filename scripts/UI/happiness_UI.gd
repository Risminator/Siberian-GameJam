extends Control

@export var target_sprite: Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if target_sprite != null:
		position = target_sprite.position - Vector2(0, target_sprite.texture.get_image().get_height() / 2) - size / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
