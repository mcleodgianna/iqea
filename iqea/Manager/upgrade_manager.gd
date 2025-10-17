extends Node

const PLAYER = preload("uid://cytanv5x0q3wx")

@export var enemy_list: Array[PackedScene]

var best_round = 0
var round = 0
var balance = 0.0
var upgrade_dict = {
	"max_health": 3,
	"attack_damage": 2
}
var default_upgrade_dict = {
	"max_health": 3,
	"attack_damage": 2
}

var enemy_health = []
var enemy_locations = []
var enemy_types = []


func reset_progress():
	upgrade_dict = default_upgrade_dict
	round = 0
	balance = 0.0
	enemy_locations = []

func set_round(to_set:int):
	round = to_set

func get_best_round():
	return best_round

func get_round():
	return round

func add_round():
	round += 1
	if round >= best_round:
		best_round = round

func get_upgrade_level(id:String):
	return upgrade_dict[id]


func get_upgrade_dict():
	return upgrade_dict

func upgrade_player(player_to_upgrade):
	player_to_upgrade.set_stats(upgrade_dict["max_health"], upgrade_dict["attack_damage"])
	player_to_upgrade.damage_taken = floor(round+10.0/10)
	return player_to_upgrade

func get_enemy_health_addition():
	return 

func set_enemy_locations(to_set: Array[Vector2]):
	enemy_locations = to_set

func set_enemy_types(to_set):
	enemy_types = to_set

func set_enemy_health(to_set):
	enemy_health = to_set

func get_enemy_health_list():
	return enemy_health

func get_enemy_by_id(id:int):
	return enemy_list[id]

func get_enemy_locations():
	return enemy_locations 
func get_enemy_types():
	return enemy_types

func modify_upgrade(upgrade:String, value: int):
	upgrade_dict[upgrade] = value

func increment_upgrade(upgrade:String):
	upgrade_dict[upgrade] += 1
	
func modify_balance(mult: int, modifier: float):
	balance += mult*modifier


func set_balance(to_set: float):
	balance = to_set

func get_balance():
	return balance
