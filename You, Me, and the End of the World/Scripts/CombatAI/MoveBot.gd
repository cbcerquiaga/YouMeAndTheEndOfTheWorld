extends "res://Scripts/CombatAI/CombatEnemy.gd"

var maxDistance
var minDistance
onready var player = get_node("../CombatPlayer")
onready var force = Vector2(0, GRAVITY)

func _ready():
	maxDistance = 655
	minDistance = 60
	pass

func jump():
	pass

func _physics_process(delta):
	staminaRegen()
	updateGravity()
	dodge(delta)
	# Integrate forces to velocity
	velocity += force * delta
	# Integrate velocity into motion and move
	velocity = move_and_slide(velocity, Vector2(0, -1))
	print(str(velocity))
	lastFrameEndSpeed = velocity
	pass

func dodge(delta):
	var distanceToPlayer = (self.global_position.x - player.global_position.x)
	if distanceToPlayer >= 0: #player is on the left
		#print("To the left to the left")
		if distanceToPlayer < maxDistance and distanceToPlayer > minDistance:
			stopWalking(delta)
		elif distanceToPlayer < minDistance: #need to move away
			#print("get away from me!")
			walkRight()
		elif distanceToPlayer > maxDistance: #need to move closer
			#print("get over here!")
			walkLeft()
	else:
		#print("To the right to the right")
		if distanceToPlayer < maxDistance and distanceToPlayer > minDistance:
			stopWalking(delta)
		elif (0 - distanceToPlayer) < minDistance:
			#print("get away from me!")
			walkLeft()
		elif (0 - distanceToPlayer) > maxDistance:
			#print("get over here!")
			walkRight()
		else:
			stopWalking(delta)
	
			
	#Four options:
		#Move forward
		#Move back
		#Jump
		#If in air, crouch
		
func walkLeft():
		if velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED:
			force.x -= WALK_FORCE
			
func walkRight():
		if velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED:
			force.x += WALK_FORCE

func stopWalking(delta):
	var vsign = sign(velocity.x)
	var vlen = abs(velocity.x)
	vlen -= STOP_FORCE * delta
	if vlen < 0:
		vlen = 0
	velocity.x = vlen * vsign
	#print("STOP!")
