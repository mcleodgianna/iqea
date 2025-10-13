extends CanvasLayer

signal transitioned_halfway

func transition():
	$AnimationPlayer.play("default")
	print("play default")
	await transitioned_halfway
	$AnimationPlayer.play_backwards("default_backwards")
	print("play default_backwards")
	

func transition_to_scene(scene_path: String):
	transition()
	await transitioned_halfway
	get_tree().change_scene_to_file(scene_path)

func emit_transitioned_halfway():
	transitioned_halfway.emit()
	
