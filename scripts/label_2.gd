extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_label(0)
	Events.happiness_updated.connect(_on_happiness_updated)

func _on_happiness_updated(_before, after) -> void:
	update_label(after)
	
func update_label(value) -> void:
	text = "%d / %d" % [value, Global.MAX_HAPPINESS]
