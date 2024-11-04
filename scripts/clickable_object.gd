extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var minigame: Global.MINI_GAMES
@export var zoom: Vector2 = Vector2(0.1, 0.1)

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


var has_mouse: bool = false
var default_scale: Vector2
var pressed: bool = false

var can_be_chosen: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	default_scale = scale
	update_collision()
	Events.minigame_chosen.connect(_on_minigame_chosen)
	Events.return_to_tavern.connect(_on_return_to_tavern)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("lmb") and has_mouse:
		scale = default_scale
		pressed = true
		Events.minigame_pressed.emit(minigame)
	if Input.is_action_just_released("lmb") and pressed:
		scale = default_scale + zoom
		pressed = false
		audio_stream_player.play()
		Events.minigame_chosen.emit(minigame)

func _on_mouse_entered() -> void:
	if can_be_chosen:
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

func _on_minigame_chosen(_chosen_minigame: Global.MINI_GAMES) -> void:
	has_mouse = false
	can_be_chosen = false
	
func _on_return_to_tavern(_chosen_minigame: Global.MINI_GAMES) -> void:
	can_be_chosen = true
