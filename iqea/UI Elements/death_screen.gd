extends CanvasLayer
@onready var animation_player = $AnimationPlayer
@onready var label_2 = $Control/Label2


var player
	

func set_player(to_set):
	player = to_set
	player.player_died.connect(_on_player_death)
	


func _on_player_death():
	animation_player.play("die")
	label_2.text = "You made it to day " + str(UpgradeManager.get_round()) + "\nBest Day: " + str(UpgradeManager.get_best_round()) + "\nEnd Balance: " + str(UpgradeManager.get_balance())


func _on_restart_button_pressed():
	MusicPlayer.set_track("res://Assets/music/gameJamDay.mp3")
	UpgradeManager.reset_progress()
	ScreenTransition.transition_to_scene("res://Screen Scenes/Main Game/Main.tscn")




func _on_quit_to_title_pressed():
	MusicPlayer.set_track("res://Assets/music/gameJamDay.mp3")
	UpgradeManager.reset_progress()
	ScreenTransition.transition_to_scene("res://Screen Scenes/Main Game/title_screen.tscn")
