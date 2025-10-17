extends AudioStreamPlayer

func set_track(to_set):
	stream = AudioStreamMP3.load_from_file(to_set)
	playing = true


func _on_finished():
	playing = true
