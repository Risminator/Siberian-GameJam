extends RigidBody2D
class_name PhysicsProp

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D

@export var sprite_texture: Texture


const MAX_SPEED = 1000
var has_mouse:bool = false
var prop_taken:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if sprite.texture == null:
		set_sprite_texture()
	if collision_polygon.polygon.is_empty():
		set_collision_to_sprite()
		
func _process(delta):
	if has_mouse and !prop_taken and Input.is_action_just_pressed("lmb"):
		set_taken(true)
	elif prop_taken and Input.is_action_just_pressed("lmb"):
		set_taken(false)
		
	if prop_taken:
		var current_position : Vector2 = self.global_position
		var mouse_position : Vector2 = get_global_mouse_position()
		
		var distance : float = current_position.distance_to(mouse_position)
		var direction : Vector2 = current_position.direction_to(mouse_position)
		
		var speed : float = min(distance, MAX_SPEED)
		
		var velocity : Vector2 = direction * speed
		move_and_collide(velocity)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var len = min(MAX_SPEED, state.linear_velocity.length())
	state.linear_velocity = state.linear_velocity.normalized() * len
	


func _on_mouse_entered() -> void:
	has_mouse = true


func _on_mouse_exited() -> void:
	has_mouse = false

func set_sprite_texture() -> void:
	sprite.texture = sprite_texture
	
func set_collision_to_sprite() -> void:
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
	collision_polygon.position = sprite.position - Vector2(sprite.texture.get_width()*sprite.scale.x/2, sprite.texture.get_height()*sprite.scale.y/2)
	collision_polygon.scale = sprite.scale



func set_taken(taken: bool) -> void:
	prop_taken = taken
	freeze = taken
