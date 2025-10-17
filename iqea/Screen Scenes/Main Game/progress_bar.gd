extends ProgressBar


var player


func set_player(to_set):
	player = to_set
	player.player_health_changed.connect(_on_health_changed)
	max_value = player.get_max_health()
	value = player.get_current_health()


func _on_health_changed():
	value = player.get_current_health()
