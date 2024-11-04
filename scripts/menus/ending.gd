extends Control

func _process(_delta):
	if Input.is_action_just_pressed("lmb") or Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("ui_right"):
		SceneChanger.change_to(Global.GAME_SCENES.MAIN_MENU)
