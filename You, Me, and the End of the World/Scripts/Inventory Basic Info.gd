extends RichTextLabel

var currentTab

func _ready():
	#currentTab = "quests"
	pass

func _process(delta):
	if currentTab == "quests":
		text = "Title                Status"
	elif currentTab == "weapons":
		text = "Weapon   Weight  Type  Damage"
	elif currentTab == "equippable":
		text = "Item   Weight   Type   Value"
	elif currentTab == "consumable":
		text = "Item  Weight  Expiration  Value"
	elif currentTab == "misc":
		text = "Item  Weight  Type   Value"
	else: #currentTab == "map":
		text = "Current Location: Testville"
	pass
