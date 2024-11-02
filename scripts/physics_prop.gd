extends RigidBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D

@export var sprite_texture: Texture

const SPEED = 50
var has_mouse:bool = false
var prop_taken:bool = false

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

func _process(delta):
	if has_mouse and !prop_taken and Input.is_action_just_pressed("lmb"):
		set_taken(true)
	elif prop_taken and Input.is_action_just_pressed("lmb"):
		set_taken(false)
		
	if prop_taken:
		var direction = global_position.direction_to(get_global_mouse_position())
		linear_velocity = SPEED * direction
		#move_and_collide()
		global_position = global_position.lerp(get_global_mouse_position(), SPEED*delta)
	

func _on_mouse_entered() -> void:
	has_mouse = true


func _on_mouse_exited() -> void:
	has_mouse = false

func set_taken(taken: bool) -> void:
	prop_taken = taken
	freeze = taken
