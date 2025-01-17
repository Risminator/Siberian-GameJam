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

@onready var restart_btn: Button = $CanvasLayer/RestartBtn

const MONSTER = preload("res://scenes/monster.tscn")

var ATTACK_COST: int = 20
const MAX_LEVELS: int = 5

var current_level: int = 1
var monsters_array: Array[Node]

static var turn = 0

@onready var head: TextureRect = $CanvasLayer/Head
@onready var win_sound: AudioStreamPlayer = $WinSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	@warning_ignore("integer_division")
	if Global.attempt > 1 and Global.HappinessValue <= Global.MAX_HAPPINESS * 4 / 5: #and (OS.has_feature("web_android") or OS.has_feature("web_ios") or OS.has_feature("mobile")):
		restart_btn.visible = true
	fight_round_ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
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
	turn += 1
	if turn != 1:
		await get_tree().create_timer(delay_time).timeout
	else:
		await get_tree().create_timer(delay_time / 2).timeout
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
	var attacks_num: int
	@warning_ignore("integer_division")
	if Global.HappinessValue <= Global.MAX_HAPPINESS * 3 / 5:
		attacks_num = 1
		@warning_ignore("integer_division")
	elif Global.HappinessValue <= Global.MAX_HAPPINESS * 4 / 5:
		attacks_num = 2
	else:
		attacks_num = 3
	if hero.has_method("attack"):
		hero.attack()
		await Events.hero_attack
	for i in range(attacks_num):
		if !monsters_array.is_empty():
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
	@warning_ignore("integer_division")
	if Global.HappinessValue <= Global.MAX_HAPPINESS * 3 / 5:
		Global.alter_happiness_by(20)
		@warning_ignore("integer_division")
	elif Global.HappinessValue <= Global.MAX_HAPPINESS * 4 / 5:
		Global.alter_happiness_by(25)
	else:
		Global.alter_happiness_by(30)
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
		turn = 0
		fight_round_ready()


func _on_restart_btn_pressed() -> void:
	SceneChanger.change_to(Global.GAME_SCENES.TAVERN)
