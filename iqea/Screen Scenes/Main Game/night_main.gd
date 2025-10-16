extends Node2D

const BASIC_ENEMY = preload("uid://kgyuiah77d0s")



func _ready():
	var enemy;
	for pos in UpgradeManager.get_enemy_locations():
		enemy = BASIC_ENEMY.instantiate()
		enemy.set_max
