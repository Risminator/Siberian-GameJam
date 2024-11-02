extends StaticBody2D

@onready var sprite: Sprite2D = $Sprite
@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D

@export var sprite_texture: Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = sprite_texture
	var bm: BitMap = BitMap.new()
	bm.create_from_image_alpha(sprite.texture.get_image())
	var rect: Rect2 = Rect2(0, 0, sprite.texture.get_width(), sprite.texture.get_height())
	var my_array: Array[PackedVector2Array] = bm.opaque_to_polygons(rect)
	
	# Create the polygon
	var pointArr = PackedVector2Array()
	for p in my_array[0]:
		pointArr.append(p)
	collision_polygon.polygon = pointArr
	
	# Place the polygon at sprite location
	# We need to offset by width and height because sprite position is from the center, whereas the polygon position is from the top left
	collision_polygon.position = sprite.position - Vector2(sprite.texture.get_width()/2, sprite.texture.get_height()/2)
