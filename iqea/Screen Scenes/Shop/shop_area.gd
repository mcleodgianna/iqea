extends Node2D

@onready var balance_label = $BalanceLabelGroup/BalanceLabel
@onready var speech = $Speech

@export var dialouge : Array[String]


func _ready():
	speech.text = dialouge.pick_random()
	balance_label.text = "Balance: " + str(UpgradeManager.get_balance())

func _on_night_button_pressed():
	ScreenTransition.transition_to_scene("res://Screen Scenes/Main Game/NightMain.tscn")


func _on_upgrade_panel_purchase_made(cost):
	balance_label.text = "Balance: " + str(UpgradeManager.get_balance())


func _on_upgrade_panel_2_purchase_made(cost):
	balance_label.text = "Balance: " + str(UpgradeManager.get_balance())


func _on_refresh_speech_pressed():
	speech.text = dialouge.pick_random()
