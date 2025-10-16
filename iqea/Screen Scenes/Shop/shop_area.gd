extends Node2D

@onready var balance_label = $BalanceLabelGroup/BalanceLabel

func _ready():
	balance_label.text = "Balance: " + str(UpgradeManager.get_balance())

func _on_night_button_pressed():
	ScreenTransition.transition_to_scene("res://Screen Scenes/Main Game/NightMain.tscn")


func _on_upgrade_panel_purchase_made(cost):
	balance_label.text = "Balance: " + str(UpgradeManager.get_balance())


func _on_upgrade_panel_2_purchase_made(cost):
	balance_label.text = "Balance: " + str(UpgradeManager.get_balance())
