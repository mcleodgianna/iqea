extends Node2D

@onready var grid: GridContainer = $Grid
@onready var catalog = $catalog
@onready var balance_label = $BalanceLabelGroup/BalanceLabel
@onready var furniture = $Furniture
@onready var balance_sprite = $BalanceLabelGroup/BalanceSprite
@onready var showcase_animation_player = $ShowcaseAnimationPlayer
@onready var balance_label_group = $BalanceLabelGroup
@onready var color_rect = $BalanceLabelGroup/ColorRect

var total_earnings = 0
var gridSize: Vector2
var selecting = false
var object
var targetCell
var objectCells
var isValid = false
var mouseInside = false
var mouse_over_catalog = false

func _ready() -> void:
	gridSize = Vector2(grid.cellWidth,grid.cellHeight)
	showcase_animation_player.animation_finished.connect(_on_animation_player_animation_finished)
	
	
func _input(_event: InputEvent) -> void:
	# showcase only
	var newPlacement
	if Input.is_action_just_pressed("leftClick") and not object and mouse_over_catalog:
		selecting = true
		newPlacement = catalog.get_current_item().instantiate()
		furniture.add_child(newPlacement)
		newPlacement.global_position = get_global_mouse_position()
		object = newPlacement
	if Input.is_action_just_pressed("rotate") and object != null:
		object.rotation += PI/2
		object.flip_rect()
		object.global_position = targetCell.global_position + object.rect.size/2
		
		_reset_highlight()
		objectCells = _get_object_cells()
		isValid = _check_and_hightlight_cells(objectCells)
		
	elif Input.is_action_just_released("leftClick"):
		selecting = false
		if isValid:
			object.set_placed(true)
			object.deleted.connect(_on_deleted_object)
			total_earnings += object.get_price()
			_place_placement(objectCells)
		else:
			if object != null:
				object.queue_free()
				_reset_highlight()
			

func _process(_delta) -> void:
	if not object or not selecting: return
	
	var mousePosition = get_global_mouse_position()
	var newTargetCell = _get_target_cell(mousePosition)
	
	if newTargetCell and newTargetCell != targetCell:
		targetCell = newTargetCell
		object.global_position = targetCell.global_position + object.rect.size/2
		
		_reset_highlight()
		objectCells = _get_object_cells()
		isValid = _check_and_hightlight_cells(objectCells)
	if not isValid or not mouseInside:
		isValid = false
		_reset_highlight()
		object.global_position = mousePosition

func _get_target_cell(targetPosition):
	for child:Control in grid.get_children():
		if child.get_global_rect().has_point(targetPosition):
			return child

func _reset_highlight():
	for child:Control in grid.get_children():
		child.change_color(Color(0,0,0,0))

func _get_other_object_cells(other_object) -> Array:
	var cells = []

	for child:Control in grid.get_children():
		if child.get_global_rect().intersects(other_object.get_global_rect()):
			cells.append(child)
			
	return cells

func _get_object_cells() -> Array:
	var cells = []

	for child:Control in grid.get_children():
		if child.get_global_rect().intersects(object.get_global_rect()):
			cells.append(child)
			
	return cells

func _check_and_hightlight_cells(_objectCells: Array):
	isValid = true
	var objectCellCount = snapped((object.rect.size.x / gridSize.x) * (object.rect.size.y / gridSize.y),0.0001)
	
	if objectCellCount != objectCells.size(): 
		isValid = false
	
	for cell in objectCells:
		if cell.full: 
			isValid = false
			cell.change_color(Color.RED)
		else:
			cell.change_color(Color.GREEN)
	
	return isValid

func _place_placement(_objectCells):
	object.global_position = targetCell.global_position + object.rect.size/2
	object.set_on_place()
	object = null
	isValid = null
	
	for cell in objectCells:
		cell.full = true
	
	_reset_highlight()

func _on_deleted_object(deleted_object):
	total_earnings -= deleted_object.price
	for cell in _get_other_object_cells(deleted_object):
		cell.full = false
	

func _on_grid_mouse_entered():
	mouseInside = true


func _on_grid_mouse_exited():
	mouseInside = false


func _on_catalog_mouse_exited():
	mouse_over_catalog = false


func _on_catalog_mouse_entered():
	mouse_over_catalog = true


func _on_end_day_button_pressed():
	var tween = create_tween()
	
	tween.set_parallel()
	
	tween.tween_property(balance_label_group, "global_position",Vector2(balance_label_group.global_position.x,balance_label_group.global_position.y+150), .5)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(balance_label_group, "scale", Vector2(3,3), .5)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.chain()
	tween.tween_property(color_rect, "color", Color(0,0,0,0.7), .5)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	
	showcase_animation_player.play("Showcase")
	UpgradeManager.set_enemy_locations(get_furniture_pos_list())

func get_furniture_pos_list():
	var pos_list: Array[Vector2]
	pos_list = []
	for child:Node2D in furniture.get_children():
		pos_list.append(child.global_position)
	return pos_list


func _on_animation_player_animation_finished(anim_name):
	if not anim_name == "Showcase":
		return
	ScreenTransition.transition_to_scene("res://Screen Scenes/Shop/shop_area.tscn")


func _on_showcase_animation_player_gold_giving():
	balance_sprite.play("Update")
	balance_label.text = "Balance: " + str(total_earnings)
