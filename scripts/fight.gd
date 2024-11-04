extends Node2D
class_name FightScene

@onready var hero: Node2D = $Playerground/Hero
@onready var monsters: Node2D = $Playerground/Monsters
@onready var happiness_bar: Control = $CanvasLayer/HappinessBar

@export var delay_time: float = 1

@onready var mark_1: Marker2D = $Playerground/Mark1
@onready var mark_2: Marker2D = $Playerground/Mark2
@onready var mark_3: Marker2D = $Playerground/Mark3
@onready var mark_4: Marker2D = $Playerground/Mark4
@onready var mark_5: Marker2D = $Playerground/Mark5

@onready var slime_1: TextureRect = $CanvasLayer/Slime1
@onready var slime_2: TextureRect = $CanvasLayer/Slime2
@onready var slime_3: TextureRect = $CanvasLayer/Slime3
@onready var slime_4: TextureRect = $CanvasLayer/Slime4
@onready var slime_5: TextureRect = $CanvasLayer/Slime5

const MONSTER = preload("res://scenes/monster.tscn")

const ATTACK_COST: float = 5
const MAX_LEVELS: int = 5

var current_level: int = 1
var monsters_array: Array[Node]

@onready var head: TextureRect = $CanvasLayer/Head
@onready var win_sound: AudioStreamPlayer = $WinSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fight_round_ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	fight_round_process()


func fight_round_ready() -> void:	
	for i in range(current_level):
		var monster = MONSTER.instantiate()
		match i:
			0:
				monster.position = mark_1.position
			1:
				monster.position = mark_2.position
			2:
				monster.position = mark_3.position
			3:
				monster.position = mark_4.position
			4:
				monster.position = mark_5.position
		monsters.add_child(monster)
		
	monsters_array = monsters.get_children()
	player_turn()
	
func fight_round_process() -> void:
	pass

func player_turn() -> void:
	await get_tree().create_timer(delay_time).timeout
	if monsters_array.size() > 0:
		while Global.HappinessValue > 0 and monsters_array.size() > 0:
			player_attack()
			await get_tree().create_timer(delay_time).timeout
			monster_turn()
			await get_tree().create_timer(delay_time).timeout
		if monsters_array.size() > 0:
			return_home()
		else:
			move_on()
	else:
		move_on()

func monster_turn() -> void:
	for monster in monsters_array:
		if monster.has_method("attack"):
			monster.attack()
			await Events.monster_attack

func player_attack() -> void:
	if hero.has_method("attack"):
		hero.attack()
		await Events.hero_attack
	var monster: Monster = monsters_array.pop_back()
	if monster.has_method("die"):
		monster.die()
	Global.alter_happiness_by(-ATTACK_COST)
	await Events.monster_dead

func return_home() -> void:
	if hero.has_method("go_home"):
		happiness_bar.visible = false
		hero.go_home()

func move_on() -> void:
	win_sound.play()
	current_level += 1
	match current_level:
		1:
			pass
		2:
			head.position = slime_1.position
			slime_1.visible = false
		3:
			head.position = slime_2.position
			slime_2.visible = false
		4:
			head.position = slime_3.position
			slime_3.visible = false
		5:
			head.position = slime_4.position
			slime_4.visible = false
		6:
			head.position = slime_5.position
			slime_5.visible = false
	if current_level > MAX_LEVELS:
		Events.game_win.emit()
		SceneChanger.change_to(Global.GAME_SCENES.ENDING)
	else:
		fight_round_ready()
