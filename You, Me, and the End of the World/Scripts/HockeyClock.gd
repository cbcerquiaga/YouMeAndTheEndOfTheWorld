extends Timer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	process_mode = Timer.TIMER_PROCESS_IDLE
	one_shot = true
	wait_time = 120.0
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
