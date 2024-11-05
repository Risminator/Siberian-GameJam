extends MiniGame

@onready var in_slots: Control = $In_Slots
@onready var progress_sfx: AudioStreamPlayer = $ProgressSFX

var correct_slots_count: int = 0
var slots_count: int

func minigame_ready() -> void:
	slots_count = in_slots.get_child_count()
	Events.slot_set.connect(_on_slot_set)
	
func start() -> void:
	pass

func minigame_process(_delta: float) -> void:
	pass
	
func minigame_exit() -> void:
	pass

func _on_slot_set() -> void:
	correct_slots_count += 1
	progress_sfx.play()
	if correct_slots_count >= slots_count:
		Events.minigame_completed.emit()
