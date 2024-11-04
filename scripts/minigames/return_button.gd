extends Button

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.minigame_completed.connect(_on_minigame_completed)

func _on_minigame_completed() -> void:
	animation_player.play("appear")

func _on_pressed() -> void:
	audio_stream_player.play()
	animation_player.play("disappear")
