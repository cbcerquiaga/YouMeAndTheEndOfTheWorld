extends KinematicBody2D

var states = ["ready","planted","not ready"]
onready var state = 2
var growthRate = 0 #increases the rate at which the plant grows and wilts
const maxGrowthRate = 15
onready var plantSprite = get_node("PlantSprite")
var plantLevel = 0 #0 shows no plant, 1 is a bud, 2 is small but harvestable, 3 is ripe, 4 is wilting, and 5 is wilted
var growthXP = 0 #determines the next time the plant "levels up"
const neededXP = 1000 #can change this for different plant types
onready var soilSprite = get_node("SoilSprite")

func _ready():
	plantSprite.visible = false
	soilSprite.frame = state
	pass

#called when the plot is struck by water from a watering can
func water():
	if state >= 1: #planted
		if growthRate < maxGrowthRate:
			growthRate = growthRate + 1
		if plantLevel > 3: #wilting
			plantLevel = plantLevel - 1
			growthXP = 0
			plantSprite.frame = plantLevel
			
func plant():
	if state == 0: #ready to plant
		state = 1
		soilSprite.frame = 1
		
			
func harvest():
	var harvest
	var rotten
	if plantLevel == 2:
		harvest = randi()%6+1 #a random number of harvested good between 1 and 5
		rotten = false
	elif plantLevel == 3:
		harvest = randi()%9 + 2 #a random number of harvested good between 2 and 8
		rotten = false
	elif plantLevel == 4:
		harvest = randi()%5 # a random number from 0 to 4
		var rottenCheck = rand_range(0,1)
		if rottenCheck < 0.5:
			rotten = false
		else:
			rotten = true
	#emit_signal("fill_basket", harvest, rotten)
	
func hoe():
	if state == 2:
		state = 0
		soilSprite.frame = state
	
func destroyPlant():
	growthRate = 0
	plantLevel = 0
	growthXP = 0
	soilSprite.frame = 2
	plantSprite.visible = false
	state = 2
	
func _process(delta):
	growthXP = growthXP + growthRate
	if growthXP > neededXP: #time to level the plant up
		plantLevel = plantLevel + 1
		if plantLevel > 5: #the plant is overwilted
			destroyPlant()
		else:
			plantSprite.frame = plantLevel
			if plantLevel > 0:
				plantSprite.visible = true
			growthXP = 0
	pass
