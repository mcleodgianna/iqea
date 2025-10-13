extends Sprite2D

@export var rect: Rect2
@export var price: float
@export var health: int
@export_multiline var desc: String
@export var view_scale_factor: float

@onready var area_2d = $Area2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var delete_button = $"Delete Button"

var mouse_inside = false
var placed = false
signal deleted(object)

func _ready():
	rect.size = self.texture.get_size()
	collision_shape_2d.shape.size = self.texture.get_size()
	delete_button.disabled = true

func get_global_rect():
	return Rect2(
		global_position - rect.size / 2,
		rect.size
	)

func get_object_texture():
	return self.texture

func flip_rect():
	rect.size = Vector2(abs(rect.size.rotated(deg_to_rad(90))))
	delete_button.rotation = -self.rotation

func get_price():
	return price

func set_on_place():
	modulate.a = 1

func set_placed(to_set:bool):
	placed = to_set

func _process(_delta):
	if delete_button.disabled:
		return
	if Input.is_action_just_pressed("leftClick") and not mouse_inside:
		delete_button.disabled = true
		delete_button.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("leftClick") and placed:
		delete_button.disabled = false
		delete_button.mouse_filter  = Control.MOUSE_FILTER_STOP
		
		


func _on_delete_button_pressed():
	emit_signal("deleted",self)
	queue_free()


func _on_area_2d_mouse_entered():
	mouse_inside = true


func _on_area_2d_mouse_exited():
	mouse_inside = false


func _on_delete_button_mouse_entered():\
	if not delete_button.disabled:
		mouse_inside = true


func _on_delete_button_mouse_exited():
	if not delete_button.disabled:
		mouse_inside = false
