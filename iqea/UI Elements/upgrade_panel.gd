extends CanvasLayer

@export_multiline var description: String
@export var upgrade_title: String
@export var cost_per_level: int
@export var max_purchases: int
@export var upgrade_id: String
@export var icon: Texture2D

var price = 0

@onready var upgrade_sprite = $"Panel/Upgrade Sprite"
@onready var upgrade_title_text = $Panel/UpgradeTitle
@onready var upgrade_description = $Panel/UpgradeDescription

func _ready():
	upgrade_sprite.texture = icon
	upgrade_title_text.text = upgrade_title
	upgrade_description.text = description
	price = UpgradeManager.get_upgrade_level(upgrade_id) * cost_per_level


func _on_purchase_button_pressed():
	if(price < UpgradeManager.get_balance()):
		UpgradeManager.increment_upgrade(upgrade_id)
		UpgradeManager.modify_balance(-1,price)
