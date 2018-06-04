extends Node2D

# class member variables go here, for example:
var isp1Playing
var isp2Playing
var cooldown = true;
var cooldown2 = true;
var timer = Timer.new()
var timer2 = Timer.new()

func _ready():
	isp1Playing = true
	isp2Playing = true
	#Handling Timer
	timer.connect("timeout",self,"_on_timer_timeout")
	timer2.connect("timeout", self, "_on_timer2_timeout")
	add_child(timer)
	add_child(timer2)
	_start_timer()
	_start_timer2()
	pass

#Function to start the timer at 1 seconds
func _start_timer():
	timer.wait_time = 1
	timer.start() #to start

#Function to start the second timer at 1 seconds
func _start_timer2():
	timer2.wait_time = 1
	timer2.start() #to start
#The function to handle when the timer times out
func _on_timer_timeout():
	cooldown = false

func _on_timer2_timeout():
	cooldown2 = false

func _pause():
	print("Game paused")
	get_tree().paused = true
	$pause_popup.show()

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
			cooldown2 = true
			isp2Playing = false
			_start_timer2()
		elif(!isp2Playing):
			cooldown2 = true
			isp2Playing = true
			_start_timer2()
	if Input.is_action_pressed("pause"):
		_pause()
	pass
