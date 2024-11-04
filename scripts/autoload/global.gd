extends Node

enum GAME_SCENES {
	MAIN_MENU,
	START_CUTSCENE,
	LEVEL,
	TAVERN,
	ENDING
}

enum MINI_GAMES {
	NO_GAME,
	REFRESHMENT,
	WEAPON_CLEANING,
	COOKING,
	HAIRCUT,
	SHELF,
	MUSIC
}

const MAIN_MENU_PATH = "res://scenes/menus/main_menu.tscn"
const START_CUTSCENE_PATH = "res://scenes/menus/cutscene.tscn"
const LEVEL_PATH = "res://scenes/levels/level.tscn"
const TAVERN_PATH = "res://scenes/levels/tavern.tscn"
const ENDING_PATH = "res://scenes/menus/ending.tscn"

const REFRESHMENT_PATH = "res://scenes/levels/minigames/mg_refreshement.tscn"
const WEAPON_CLEANING_PATH = "res://scenes/levels/minigames/mg_weapon_cleaning.tscn"
const COOKING_PATH = "res://scenes/levels/minigames/mg_cooking.tscn"
const HAIRCUT_PATH = "res://scenes/levels/minigames/mg_haircut.tscn"
const SHELF_PATH = "res://scenes/levels/minigames/mg_shelf.tscn"
const MUSIC_PATH = "res://scenes/levels/minigames/mg_music.tscn"

const MINIGAME_PATHS: Array[String] = [REFRESHMENT_PATH, WEAPON_CLEANING_PATH, COOKING_PATH, HAIRCUT_PATH, SHELF_PATH, MUSIC_PATH]

var SoundEffectsVolume = 0
var MusicVolume = 0

### HappinessMeter

var HappinessValue = 0

func reset_happiness() -> void:
	HappinessValue = 0
