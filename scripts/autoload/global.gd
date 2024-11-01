extends Node

enum GAME_SCENES {
	MAIN_MENU,
	START_CUTSCENE,
	LEVEL,
	ENDING
}

const MAIN_MENU_PATH = "res://scenes/menus/main_menu.tscn"
const START_CUTSCENE_PATH = "res://scenes/menus/cutscene.tscn"
const LEVEL_PATH = "res://scenes/levels/level.tscn"
const ENDING_PATH = "res://scenes/menus/ending.tscn"

var SoundEffectsVolume = 0
var MusicVolume = 0
