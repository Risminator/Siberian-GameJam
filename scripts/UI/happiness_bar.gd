extends TextureProgressBar
class_name HappinessBar

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const FILL_ANIMATION = "fill"
const DEPLETE_ANIMATION = "deplete"
const BAR_NAME = "."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    min_value = Global.MIN_HAPPINESS
    max_value = Global.MAX_HAPPINESS
    value = Global.HappinessValue
    Events.happiness_updated.connect(_on_happiness_updated)
    # test_happiness_animations()
    

func update_health_bar(before: int, after: int) -> void:
    var animation: Animation
    var animation_name: String = FILL_ANIMATION if after > before else DEPLETE_ANIMATION

    animation = animation_player.get_animation(animation_name)
    var track_name = '%s:value' % BAR_NAME
    var track = animation.find_track(track_name,Animation.TYPE_VALUE)
    var before_key = animation.track_find_key(track, 0)
    var after_key = animation.track_find_key(track, animation.track_get_key_count(track) - 1)
    animation.track_set_key_value(track, before_key, before)
    animation.track_set_key_value(track, after_key, after)
    animation_player.play(animation_name)

func test_happiness_animations() -> void:
    await get_tree().create_timer(2).timeout
    update_health_bar(0, 50)
    await animation_player.animation_finished
    await get_tree().create_timer(0.5).timeout
    update_health_bar(50, 75)
    await animation_player.animation_finished
    await get_tree().create_timer(0.5).timeout
    update_health_bar(75, 100)
    await animation_player.animation_finished
    await get_tree().create_timer(0.5).timeout
    update_health_bar(100, 50)
    await animation_player.animation_finished
    await get_tree().create_timer(0.5).timeout
    update_health_bar(50, 25)
    await animation_player.animation_finished
    await get_tree().create_timer(0.5).timeout
    update_health_bar(25, 0)

func _on_happiness_updated(before: int, after: int) -> void:
    if after > before:
        Events.happiness_increased.emit(before, after)
    else:
        Events.happiness_decreased.emit(before, after)
    update_health_bar(before, after)
