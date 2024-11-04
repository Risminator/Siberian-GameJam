extends AudioStreamPlayer2D

@onready var st = stream as AudioStreamInteractive

enum LOCATION_MUSIC_IDS {
	TAVERN = 0,
	BATTLE = 1
}

var current_track_id: int = 0

var is_satisfied: bool = false

var music_ids = {
	Global.GAME_SCENES.MAIN_MENU: LOCATION_MUSIC_IDS.TAVERN,
	Global.GAME_SCENES.START_CUTSCENE: LOCATION_MUSIC_IDS.TAVERN,
	Global.GAME_SCENES.LEVEL: LOCATION_MUSIC_IDS.TAVERN,
	Global.GAME_SCENES.TAVERN: LOCATION_MUSIC_IDS.TAVERN,
	Global.GAME_SCENES.ENDING: LOCATION_MUSIC_IDS.TAVERN,
	Global.GAME_SCENES.FIGHT: LOCATION_MUSIC_IDS.BATTLE
}


func _inital_music(track: LOCATION_MUSIC_IDS) -> void:
	var playback = get_stream_playback()
	if playback:
		playback.switch_to_clip(track)


func _ready() -> void:
	play()
	_inital_music(LOCATION_MUSIC_IDS.TAVERN)
	
	Events.transition_start.connect(_on_transition_start)

func _process(_delta: float) -> void:
	pass

func _on_transition_start(new_scene: Global.GAME_SCENES) -> void:
	var playback = get_stream_playback()
	var music_id = music_ids.get(new_scene, null)
	playback.switch_to_clip(music_id)
