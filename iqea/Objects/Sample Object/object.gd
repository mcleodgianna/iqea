extends Sprite2D

@export var rect: Rect2
@export var price: int
@export var health: int

func get_global_rect():
	return Rect2(
		global_position - rect.size / 2,
		rect.size
	)

func flip_rect():
	rect.size = Vector2(abs(rect.size.rotated(deg_to_rad(90))))

func set_on_place():
	modulate.a = 1
