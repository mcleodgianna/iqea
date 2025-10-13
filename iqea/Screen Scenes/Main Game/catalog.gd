extends Area2D

@export var items: Array[PackedScene]
@onready var selected_item_sprite = $SelectedItemSprite
@onready var object_information = $"Object Information"

var mouse_inside = false
var current_item

func _ready():
	if items.size() == 0:
		return
	current_item = items.get(0)
	refresh_texture()

func get_current_item():
	return current_item

func refresh_texture():
	var instantiated_item = current_item.instantiate()
	selected_item_sprite.texture = instantiated_item.texture
	
	var texture_scale = instantiated_item.view_scale_factor
	selected_item_sprite.scale = Vector2(texture_scale,texture_scale)
	object_information.update_information(instantiated_item.price,instantiated_item.health,instantiated_item.desc)
	instantiated_item.queue_free()

func _on_button_pressed():
	if items.find(current_item) == -1 or items.size() == 0:
		return
	if items.find(current_item) + 1 == items.size():
		current_item = items.get(0)
	else:
		current_item = items.get(items.find(current_item) + 1)
	refresh_texture()
