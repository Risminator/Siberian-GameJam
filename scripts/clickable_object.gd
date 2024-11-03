extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var minigame: Global.MINI_GAMES
@export var zoom: Vector2 = Vector2(0.1, 0.1)

var has_mouse: bool = false
var default_scale: Vector2
var pressed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	default_scale = scale
	update_collision()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("lmb") and has_mouse:
		scale = default_scale
		pressed = true
		Events.minigame_pressed.emit(minigame)
	if Input.is_action_just_released("lmb") and pressed:
		scale = default_scale + zoom
		pressed = false
		Events.minigame_chosen.emit(minigame)

func _on_mouse_entered() -> void:
	scale = default_scale + zoom
	has_mouse = true
	Events.minigame_hover.emit(minigame)


func _on_mouse_exited() -> void:
	scale = default_scale
	has_mouse = false
	Events.minigame_hover_stopped.emit(minigame)

func update_collision() -> void:
	var rect: Rect2 = sprite_2d.get_rect()
	var collision_rect: RectangleShape2D = RectangleShape2D.new()
	collision_rect.size = rect.size
	collision_shape_2d.shape = collision_rect
