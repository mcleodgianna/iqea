extends AnimationPlayer


signal gold_giving

func emit_gold_giving():
	gold_giving.emit()
