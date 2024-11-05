extends PanelContainer

@onready var texture_rect: TextureRect = $TextureRect

const DRAGPREVIEW = preload("res://scenes/levels/minigames/mg_shelf/drag_preview.tscn")
const PREVIEW_SIZE: Vector2 = Vector2(100, 100)

@export var correct_texture: Texture2D


const POLEARM_IN: Texture2D = preload("res://assets/props/polearm.png_vertical.png")
const POLEARM_OUT: Texture2D = preload("res://assets/props/polearm.png")
const SWORD_IN: Texture2D = preload("res://assets/props/sword.png_vertical.png")
const SWORD_OUT: Texture2D = preload("res://assets/props/sword.png")

func _get_drag_data(_at_position: Vector2) -> Variant:	
	if texture_rect.texture != null:
		var drag_preview = DRAGPREVIEW.instantiate()
		if texture_rect.texture == POLEARM_IN:
			drag_preview.texture = POLEARM_OUT
		elif texture_rect.texture == SWORD_IN:
			drag_preview.texture = SWORD_OUT
		else:
			drag_preview.texture = texture_rect.texture
		drag_preview.scale = PREVIEW_SIZE / texture_rect.texture.get_size()
		add_child(drag_preview)
		return texture_rect
	else:
		return null

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is TextureRect and correct_texture.resource_path.contains(data.texture.resource_path)

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var temp = texture_rect.texture
	if data.texture == POLEARM_OUT:
		texture_rect.texture = POLEARM_IN
	elif data.texture == SWORD_OUT:
		texture_rect.texture = SWORD_IN
	else:
		texture_rect.texture = data.texture
	data.texture = temp
	Events.slot_set.emit()
