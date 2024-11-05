extends Control

@onready var completed_time_label: Label = $CompletedTimeLabel
@onready var record_time_label: Label = $RecordTimeLabel

func _ready() -> void:
	completed_time_label.text = "Completion Time: %.2f s" % Global.time_completed
	record_time_label.text = "Best Time: %.2f s" % Global.time_record

func _process(_delta):
	if Input.is_action_just_pressed("lmb") or Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("ui_right"):
		SceneChanger.change_to(Global.GAME_SCENES.MAIN_MENU)
