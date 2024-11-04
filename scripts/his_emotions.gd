extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.happiness_updated.connect(_on_happiness_updated)
	var current_happiness = Global.HappinessValue
	update_sprite(current_happiness)
		
func _on_happiness_updated(before:int , after:int) -> void:
	update_sprite(after)

func update_sprite(current_happiness: int) -> void:
	if current_happiness <= 35:
		play("1")
	elif current_happiness <= 70:
		play("2")
	elif current_happiness <= 105:
		play("3")
	elif current_happiness <= 140:
		play("4")
	else:
		play("5")
