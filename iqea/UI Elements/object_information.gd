extends Label


func update_information(price: float, durability: int, desc: String):
	self.text = "Price: " + str(price) + "\nDurability: " + str(durability + UpgradeManager.get_round()*3) + "\n" + desc
