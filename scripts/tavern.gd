extends Node2D

@onready var loading_box: PanelContainer = $CanvasLayer/LoadingBox
@onready var loaded_count_label: Label = $CanvasLayer/LoadingBox/VBoxContainer/LoadedCountLabel
@onready var timer: Timer = $CanvasLayer/VBoxContainer/PanelContainer/TimeLabel/Timer


@onready var clickable_mini_games: Node2D = $ClickableMiniGames
@onready var restart_btn: Button = $CanvasLayer/VBoxContainer/RestartBtn

var current_minigame: Global.MINI_GAMES = Global.MINI_GAMES.NO_GAME

var mg_instance_refreshment: PackedScene
var mg_instance_weapon_cleaning: PackedScene
var mg_instance_cooking: PackedScene
var mg_instance_haircut: PackedScene
var mg_instance_shelf: PackedScene
var mg_instance_music: PackedScene

var everything_loaded: bool = false
var scene_load_status: Array[ResourceLoader.ThreadLoadStatus] = [ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS, ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS, ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS, ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS, ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS, ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS]
var load_progress = []
const MINIGAME_COUNT = 6

var clickables_array: Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.attempt += 1
	if Global.attempt > 3 and Global.HappinessValue <= 125 and (OS.has_feature("web_android") or OS.has_feature("web_ios")):
		restart_btn.visible = true
	Global.reset_happiness()
	start_loading_minigames()
	Events.minigame_chosen.connect(_on_minigame_chosen)
	Events.return_to_tavern.connect(_on_return_to_tavern)
	Events.happiness_maxed.connect(go_to_battle)
	timer.timeout.connect(go_to_battle)
	timer.start()
	Events.return_to_tavern.emit(Global.MINI_GAMES.NO_GAME)
	clickables_array = clickable_mini_games.get_children()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !everything_loaded:
		var loaded_count: int = get_loading_statuses()
		loaded_count_label.text = "%d%%" % (loaded_count * 100.0 / MINIGAME_COUNT)
		if is_loading_status_ready():
			assign_loaded_scenes_instances()
			everything_loaded = true
			loading_box.visible = false
			


func _on_minigame_chosen(minigame: Global.MINI_GAMES) -> void:
	if current_minigame == Global.MINI_GAMES.NO_GAME:
		current_minigame = minigame
		var chosen_minigame: PackedScene
		match minigame:
			Global.MINI_GAMES.REFRESHMENT:
				chosen_minigame = mg_instance_refreshment
			Global.MINI_GAMES.WEAPON_CLEANING:
				chosen_minigame = mg_instance_weapon_cleaning
			Global.MINI_GAMES.COOKING:
				chosen_minigame = mg_instance_cooking
			Global.MINI_GAMES.HAIRCUT:
				chosen_minigame = mg_instance_haircut
			Global.MINI_GAMES.SHELF:
				chosen_minigame = mg_instance_shelf
			Global.MINI_GAMES.MUSIC:
				chosen_minigame = mg_instance_music
		start_minigame(chosen_minigame)

func _on_return_to_tavern(_completed_minigame: Global.MINI_GAMES) -> void:
	current_minigame = Global.MINI_GAMES.NO_GAME
	#for clickable:ClickableMiniGame in clickables_array:
		#if clickable.minigame == _completed_minigame:
			#clickable.cool_down = clickable.max_cool_down
		#else:
			#clickable.cool_down -= 1

func start_minigame(chosen_minigame: PackedScene) -> void:
	var minigame_instance: MiniGame = chosen_minigame.instantiate()
	add_child(minigame_instance)
	

func get_loading_statuses() -> int:
	for i in MINIGAME_COUNT:
		scene_load_status[i] = ResourceLoader.load_threaded_get_status(Global.MINIGAME_PATHS[i], load_progress)
	return scene_load_status.count(ResourceLoader.THREAD_LOAD_LOADED)

func start_loading_minigames() -> void:
	ResourceLoader.load_threaded_request(Global.REFRESHMENT_PATH)
	ResourceLoader.load_threaded_request(Global.WEAPON_CLEANING_PATH)
	ResourceLoader.load_threaded_request(Global.COOKING_PATH)
	ResourceLoader.load_threaded_request(Global.HAIRCUT_PATH)
	ResourceLoader.load_threaded_request(Global.SHELF_PATH)
	ResourceLoader.load_threaded_request(Global.MUSIC_PATH)

func assign_loaded_scenes_instances() -> void:
	mg_instance_refreshment = ResourceLoader.load_threaded_get(Global.REFRESHMENT_PATH)
	mg_instance_weapon_cleaning = ResourceLoader.load_threaded_get(Global.WEAPON_CLEANING_PATH)
	mg_instance_cooking = ResourceLoader.load_threaded_get(Global.COOKING_PATH)
	mg_instance_haircut = ResourceLoader.load_threaded_get(Global.HAIRCUT_PATH)
	mg_instance_shelf = ResourceLoader.load_threaded_get(Global.SHELF_PATH)
	mg_instance_music = ResourceLoader.load_threaded_get(Global.MUSIC_PATH)

func is_loading_status_ready() -> bool:
	return scene_load_status.filter(func(status): return status == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED).size() >= MINIGAME_COUNT

func go_to_battle() -> void:
	Events.go_to_battle.emit()
	SceneChanger.change_to(Global.GAME_SCENES.FIGHT)
