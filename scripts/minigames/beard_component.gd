extends Area2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


var has_mouse: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if sprite.texture != null and collision_polygon.polygon.is_empty():
		set_collision_to_sprite()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("lmb") and has_mouse:
		Events.beard_cut.emit()
		animation_player.play("cut")
		audio_stream_player.play()


func set_collision_to_sprite() -> void:
	var bm: BitMap = BitMap.new()
	bm.create_from_image_alpha(sprite.texture.get_image())
	var rect: Rect2 = Rect2(0, 0, sprite.texture.get_width(), sprite.texture.get_height())
	var my_array: Array[PackedVector2Array] = bm.opaque_to_polygons(rect)
	#print(my_array.size())
	# Create the polygon
	var pointArr = PackedVector2Array()
	var num = 0
	if my_array.size() > 1:
		num = my_array.size() - 1
	for p in my_array[num]:
		pointArr.append(p)
	collision_polygon.polygon = pointArr
	
	# Place the polygon at sprite location
	# We need to offset by width and height because sprite position is from the center, whereas the polygon position is from the top left
	collision_polygon.position = sprite.position - Vector2(sprite.texture.get_width()*sprite.scale.x/2, sprite.texture.get_height()*sprite.scale.y/2)
	collision_polygon.scale = sprite.scale
	#print(collision_polygon.position, " ", collision_polygon.scale, " ", collision_polygon.polygon.size())


func _on_mouse_entered() -> void:
	has_mouse = true

func _on_mouse_exited() -> void:
	has_mouse = false
