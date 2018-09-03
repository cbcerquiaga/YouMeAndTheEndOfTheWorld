extends "res://Scripts/CombatAI/CombatEnemy.gd"

var maxDistance
var minDistance

func _ready():
	maxDistance = 800
	minDistance = 600
	pass

func jump():
	pass

func dodge():
	var distanceToPlayer = (self.global_position - player.global_position).length()
	if distanceToPlayer >= 0: #player is on the left
		print("To the left to the left")
		if distanceToPlayer < minDistance: #need to move away
			print("get away from me!")
		elif distanceToPlayer > maxDistance: #need to move closer
			print("get over here!")
	else:
		print("To the right to the right")
		if (0 - distanceToPlayer) < minDistance:
			print("get away from me!")
		elif (0 - distanceToPlayer) > maxDistance:
			print("get over here!")
	#Four options:
		#Move forward
		#Move back
		#Jump
		#If in air, crouch
