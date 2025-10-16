extends Node2D

const BASIC_ENEMY = preload("uid://kgyuiah77d0s")
const PLAYER = preload("uid://cytanv5x0q3wx")


@onready var furniture = $Furniture
var ended = false

func _process(delta):
	if furniture.get_child_count() == 0 and not ended:
		UpgradeManager.add_round()
		ScreenTransition.transition_to_scene("res://Screen Scenes/Main Game/Main.tscn")
		ended = true
		

func _ready():
	var enemy: CharacterBody2D
	for pos in UpgradeManager.get_enemy_locations():
		enemy = BASIC_ENEMY.instantiate()
		furniture.add_child(enemy)
		enemy.global_position = pos
		enemy.set_max_health(UpgradeManager.get_round() + 10)
	
	var player :CharacterBody2D = PLAYER.instantiate()
	get_tree().root.add_child(player)
	UpgradeManager.upgrade_player(player)
	player.global_position = Vector2(320,170)
