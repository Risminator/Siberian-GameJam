extends Node2D
class_name FightScene

@onready var hero: Node2D = $Playerground/Hero
@onready var monsters: Node2D = $Playerground/Monsters

@export var delay_time: float = 1

const ATTACK_COST: float = 10

var monsters_array: Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	monsters_array = monsters.get_children()
	Global.alter_happiness_by(50)
	fight_round_ready()
	player_turn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	fight_round_process()


func fight_round_ready() -> void:
	pass
	
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
	pass

func move_on() -> void:
	print("I won!")
