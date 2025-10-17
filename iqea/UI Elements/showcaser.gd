extends AnimationPlayer


signal gold_giving

func emit_gold_giving():
	SoundEffectPlayer.set_track("res://Assets/sfx/Jackpot.mp3")
	gold_giving.emit()
