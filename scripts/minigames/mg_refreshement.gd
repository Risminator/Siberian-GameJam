extends MiniGame

@onready var beer_spawners: Node2D = $BeerSpawners
@onready var beer_particles: Node2D = $BeerParticles
@onready var progress_sfx: AudioStreamPlayer = $ProgressSFX

const BEER_PARTICLE = preload("res://scenes/levels/minigames/mg_refreshment/beer_particle.tscn")

var beer_spawners_array: Array[Node]

var beer_collected: int = 0
var beer_criteria: int = 50

func minigame_ready() -> void:
	beer_spawners_array = beer_spawners.get_children()


func _on_timer_timeout() -> void:
	if is_game_active:
		var beer_instance: RigidBody2D = BEER_PARTICLE.instantiate()
		beer_instance.position = beer_spawners_array.pick_random().position
		beer_particles.add_child(beer_instance)


func _on_beer_collector_body_entered(body: Node2D) -> void:
	if body != null and body is Beer:
		body.queue_free()
		progress_sfx.play()
		beer_collected += 1
		if beer_collected >= beer_criteria and is_game_active:
			Events.minigame_completed.emit()
			is_game_active = false
			
