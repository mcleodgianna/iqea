extends Node2D

const BASIC_ENEMY = preload("uid://kgyuiah77d0s")
const PLAYER = preload("uid://cytanv5x0q3wx")
@onready var death_screen = $DeathScreen
@onready var win_particles = $"Win Particles"
@onready var win_timer = $WinTimer
@onready var progress_bar = $ProgressBar


@onready var furniture = $Furniture
var ended = false
var pause_start = false
func _process(_delta):
	if furniture.get_child_count() == 0:
		win_particles.emitting = true
		if not pause_start:
			SoundEffectPlayer.set_track("res://Assets/sfx/Children Yay Sound Effect (HD).mp3")
			win_timer.start()
			pause_start = true

func _ready():
	MusicPlayer.set_track("res://Assets/music/ForMakGame(1).mp3")
	var enemy: CharacterBody2D
	for i in  range(UpgradeManager.get_enemy_locations().size()):
		enemy = UpgradeManager.get_enemy_by_id(UpgradeManager.get_enemy_types().get(i)).instantiate()
		furniture.add_child(enemy)
		enemy.global_position = UpgradeManager.get_enemy_locations().get(i)
		enemy.set_max_health(UpgradeManager.get_round()*3 + UpgradeManager.get_enemy_health_list().get(i))
	
	var player :CharacterBody2D = PLAYER.instantiate()
	get_tree().root.add_child(player)
	UpgradeManager.upgrade_player(player)
	player.global_position = Vector2(320,170)
	death_screen.set_player(player)
	progress_bar.set_player(player)


func _on_win_timer_timeout():
	MusicPlayer.set_track("res://Assets/music/gameJamDay.mp3")
	UpgradeManager.add_round()
	ScreenTransition.transition_to_scene("res://Screen Scenes/Main Game/Main.tscn")
	var player = get_tree().get_first_node_in_group("player")
	player.queue_free()
