extends Control


func _on_button_pressed() -> void:
	SceneChanger.change_to(Global.GAME_SCENES.TAVERN)
