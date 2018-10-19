extends Area2D

func _ready():
	pass

func collidingWithPlayer():
	print("checking collision")
	var collideCheck = get_overlapping_bodies()
	if(collideCheck != null):
		for i in collideCheck:
			print(str(i))
			if i == "CombatPlayer":
				return true
	return false

func _process(delta):
	if Input.is_action_just_pressed("p1_action1") and collidingWithPlayer(): #dash left button, <
		print("Player tagged out")
	pass
