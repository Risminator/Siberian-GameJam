extends MiniGame

@onready var progress_sfx: AudioStreamPlayer = $ProgressSFX
@onready var vegetables: Node2D = $Vegetables

var vegetables_count: int
var picked_vegetables: int = 0


func minigame_ready() -> void:
	vegetables_count = vegetables.get_child_count()


func minigame_start() -> void:
	for vegetable: RigidBody2D in vegetables.get_children():
		vegetable.freeze = false


func _on_area_2d_body_entered(body: PhysicsProp) -> void:
	picked_vegetables += 1
	progress_sfx.play()
	if picked_vegetables >= vegetables_count:
		Events.minigame_completed.emit()
	body.set_taken(false)
	body.input_pickable = false
	await get_tree().create_timer(0.1).timeout
	body.queue_free()
