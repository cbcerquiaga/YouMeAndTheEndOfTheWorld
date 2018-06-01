extends Node2D

# class member variables go here, for example:
var isp1Playing
var isp2Playing
var cooldown = true;
var timer = Timer.new()

func _ready():
	isp1Playing = true
	isp2Playing = true
	#Handling Timer
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer)
	_start_timer()
	pass

#Function to start the timer at 1 seconds
func _start_timer():
	timer.wait_time = 1
	timer.start() #to start

#The function to handle when the timer times out
func _on_timer_timeout():
	cooldown = false
	

func _process(delta):
	if Input.is_action_pressed("p1_dropout") and !cooldown:
		if(isp1Playing && isp2Playing):
			cooldown = true
			isp1Playing = false
			_start_timer()
		elif(!isp1Playing):
			cooldown = true
			isp1Playing = true
			_start_timer()
	if Input.is_action_pressed("p2_dropout") and !cooldown:
		if(isp1Playing && isp2Playing):
			isp2Playing = false
		elif(!isp2Playing):
			isp2Playing = true
	pass
