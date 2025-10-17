extends Node2D

func _ready():
	MusicPlayer.set_track("res://Assets/music/gameJamDay.mp3")


func _on_play_button_pressed():
	ScreenTransition.transition_to_scene("res://Screen Scenes/Main Game/intro_scene.tscn")


func _on_quit_pressed():
	get_tree().quit()
