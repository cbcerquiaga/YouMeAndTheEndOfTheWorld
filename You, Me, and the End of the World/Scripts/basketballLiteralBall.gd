extends RigidBody2D

onready var isHeld #if the ball is held, it can be thrown. If not, it's free
var holdingPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_bounce(.7)
	isHeld = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isHeld:
		self.position.x = holdingPlayer.holdArea.global_position.x
		self.position.y = holdingPlayer.holdArea.global_position.y
	#if mouse clicked and isHeld:
		#check mouse position
		#get distance from ball
		#turn distance into force quantity
		#get angle from ball
		#apply_force(angle, force)
		#isHeld = false
	#if held but not clicked:
		#snap to position for heldPlayer
	#else:
		#check if close enough to be held
			#if yes, set held to be true
	pass
