extends Node

const PLAYER = preload("uid://cytanv5x0q3wx")

var round = 0
var balance = 0.0
var upgrade_dict = {
	"max_health": 3,
	"attack_damage": 2
}
var enemy_locations = []

func set_round(to_set:int):
	round = to_set

func get_round():
	return round

func add_round():
	round += 1

func get_upgrade_level(id:String):
	return upgrade_dict[id]


func get_upgrade_dict():
	return upgrade_dict

func get_upgraded_player():
	var player = PLAYER.instantiate()
	player.set_stats(upgrade_dict["max_health"], upgrade_dict["attack_damage"])
	return player

func set_enemy_locations(to_set: Array[Vector2]):
	enemy_locations = to_set

func get_enemy_locations():
	return enemy_locations 

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
