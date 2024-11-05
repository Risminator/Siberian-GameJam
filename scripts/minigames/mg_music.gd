extends MiniGame

@onready var progress_sfx: AudioStreamPlayer = $ProgressSFX
@onready var coins: Node2D = $Coins

var coin_count: int
var picked_coins: int = 0


func minigame_ready() -> void:
	coin_count = coins.get_child_count()
	
	
func minigame_start() -> void:
	for coin: RigidBody2D in coins.get_children():
		coin.freeze = false


func _on_area_2d_body_entered(body: PhysicsProp) -> void:
	picked_coins += 1
	progress_sfx.play()
	if picked_coins >= coin_count:
		Events.minigame_completed.emit()
	body.set_taken.call_deferred(false)
	body.input_pickable = false
	await get_tree().create_timer(0.1).timeout
	body.queue_free()
