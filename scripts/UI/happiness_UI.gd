extends Control

@export var target_sprite: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if target_sprite != null:
		position = target_sprite.position - Vector2(0, target_sprite.sprite_frames.get_frame_texture("5", 0).get_height() / 2) - size / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
