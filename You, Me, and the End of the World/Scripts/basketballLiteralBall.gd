extends RigidBody2D

onready var isHeld #if the ball is held, it can be thrown. If not, it's free
var holdingPlayer

const minPower = .2
const maxPower = .6

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_bounce(.7)
	isHeld = false
	pass
	
func shoot_ball():
	var mousePos = get_local_mouse_position()
	var selfPos = self.get_global_position()
	var power = (selfPos - mousePos).normalized()
	power.x = power.x/2
	power.y = power.y/2
	if power.y < minPower:
		power.y = minPower
	elif power.y > maxPower:
		power.y = maxPower
	if power.x < -maxPower:
		power.x = -maxPower
	elif power.x > maxPower:
		power.x = maxPower
	#add spread to mouse position
	var randSpread = int(rand_range(-holdingPlayer.spread,holdingPlayer.spread))
	mousePos.x += randSpread
	randSpread = int(rand_range(-holdingPlayer.spread,holdingPlayer.spread))
	mousePos.y += randSpread
	#find angle
	var angle = selfPos.angle_to(mousePos)
	var offset = Vector2(cos(angle), sin(angle))
	#launch the ball
	isHeld = false
	holdingPlayer.canCatchBall = false
	apply_impulse(offset, power)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isHeld:
		self.position.x = holdingPlayer.holdArea.global_position.x
		self.position.y = holdingPlayer.holdArea.global_position.y
		if Input.is_action_just_pressed("click") and !holdingPlayer.isMouseNull:
			shoot_ball()
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
