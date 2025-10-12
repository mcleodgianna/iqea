extends Area2D

@export var items: Array[PackedScene]

var mouse_inside = false
var current_item

func _ready():
	if items.size() == 0:
		return
	current_item = items.get(0)

func get_current_item():
	return current_item


func _on_button_pressed():
	if items.find(current_item) == -1 or items.size() == 0:
		return
	if items.find(current_item) + 1 == items.size():
		current_item = items.get(0)
	else:
		current_item = items.get(items.find(current_item) + 1)
