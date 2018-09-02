extends KinematicBody2D

#jump variables and constants
const JUMP_VELOCITY = 4.5
const JUMP_CUT_VAL = 1
const GRAVITY = 0.1
const CROUCH_GRAVITY = 2.5
var timeHeld = 0
var timeForFullJump = 0.1
var motion = Vector2()
const BULLET = preload("res://tscn files/Bullet.tscn")

#combat-affecting variables
var isCrouched = false
var isInAir = false
var meleeDamageBonus #based on perks
var rangedSpreadBonus #based on perks
var rangedWeapon #check the player's inventory for an equipped
	#ranged weapon. This affects fire rate, spread, projectile speed,
	#how many shots can be fired, damage, and bonus affects
var meleeWeapon #check the player's inventory for an equipped
	#melee weapon. This affects reach, damage, grappling, blocking,
	#speed, and bonus affects
var ammoLeft = 6
var ammoVal = str(ammoLeft)

#AI affecting variables
var tauntEffect = 0 #0 no effect, 1 taunt back, 2 rage
var mercy = 3 #from 0 to 5, affects chances of successful surrender
var greed = 0 #from 0 to 3, affects how much the enemy will steal if the player surrenders
var spite = 0 #from 0 to 3, affects how much the enemy maims a player that surrenders
var runStopVal = .5 #TODO: figure out how different enemy stats impact run away chances

#status variables
var headDamageMultiplier = 2
var totalHealth = 100 #heavily weights head and torso health
var bleedRate
var stamina = 100 #the player's current stamina level
var maxStamina = 100 #the maximum stamina the player can have with their current fitness
var staminaRegen = .25 #how quickly the player's stamina regenerates
var agility
var strength
var maxHealth = 100

func staminaRegen():
	if (stamina < 100):
		stamina += staminaRegen
	if (stamina < 0):
		stamina = 0
	if (stamina > maxStamina):
		stamina = maxStamina

func updateGravity():
		#apply movement and gravity
		motion.y += GRAVITY
		self.move_and_collide(motion)

func _on_Bullet_hit(bodyPart, damage, critChance):
	print("Hit! " + str(totalHealth))
	var randNum = rand_range(0,1)
	if bodyPart == "torso":
		if randNum > critChance: #not a critical hit
			totalHealth = totalHealth - damage
		else: #50% bonus damage
			print("CRITICAL STRIKE")
			totalHealth = totalHealth - (damage * 3/2)
	elif bodyPart == "head":
		if randNum > critChance: #not a critical hit
			totalHealth = (totalHealth - (damage*headDamageMultiplier))
		else:
			print("CRITICAL STRIKE")
			totalHealth = totalHealth - ((damage*headDamageMultiplier) * 3/2)
	print(str(totalHealth))
	pass
