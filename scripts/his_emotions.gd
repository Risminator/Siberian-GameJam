extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.happiness_updated.connect(_on_happiness_updated)
	var current_happiness = Global.HappinessValue
	update_sprite(current_happiness)
		
func _on_happiness_updated(_before:int , after:int) -> void:
	update_sprite(after)

func update_sprite(current_happiness: int) -> void:
	@warning_ignore("integer_division")
	if current_happiness <= Global.MAX_HAPPINESS * 1 / 5:
		play("1")
		@warning_ignore("integer_division")
	elif current_happiness <= Global.MAX_HAPPINESS * 2 / 5:
		play("2")
		@warning_ignore("integer_division")
	elif current_happiness <= Global.MAX_HAPPINESS * 3 / 5:
		play("3")
		@warning_ignore("integer_division")
	elif current_happiness <= Global.MAX_HAPPINESS * 4 / 5:
		play("4")
	else:
		play("5")
