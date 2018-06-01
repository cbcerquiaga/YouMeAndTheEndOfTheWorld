extends Node2D

# class member variables go here, for example:
var isp1Playing
var isp2Playing

func _ready():
	isp1Playing = true
	isp2Playing = true
	pass

func _process(delta):
	if Input.is_action_pressed("p1_dropout"):
		if(isp1Playing && isp2Playing):
			isp1Playing = false
		elif(!isp1Playing):
			isp1Playing = true
	if Input.is_action_pressed("p2_dropout"):
		if(isp1Playing && isp2Playing):
			isp2Playing = false
		elif(!isp2Playing):
			isp2Playing = true
	pass
