extends Node2D

# class member variables go here, for example:
var isp1Playing
var isp2Playing

func _ready():
	isp1Playing = true
	#isp2Playing = true
	pass

func _process(delta):
	if Input.is_action_pressed("p1_dropout"):
		print("player 1 pressed dropout button")
		if(isp1Playing && isp2Playing):
			print("both players playing, p1 drops out")
			isp1Playing = false
		if(!isp1Playing):
			print("dropped in")
			isp1Playing = true
	if Input.is_action_pressed("p2_dropout"):
		print("player 2 pressed dropout button")
		if(isp1Playing && isp2Playing):
			print("both players playing, p2 drops out")
			isp2Playing = false
		if(!isp2Playing):
			isp2Playing = true
			print("dropped in")
	pass
