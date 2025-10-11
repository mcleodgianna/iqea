extends Area2D

@export var items: Array[PackedScene]
var current_item

func _ready():
	current_item = items.get(0)
