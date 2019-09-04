extends KinematicBody2D

var damage = 100 #default damage
var critChance = .2 #default critical chance
var speed = 500 #default speed 500
var motion = Vector2(2,0)
var distance = 0
var maxDistance = 1000

onready var mySprite = get_node("Sprite")
var creature
var creatureSprite

signal hit
signal hitUpdate

func _ready():
	set_process(true)
#	if(!self.is_connected("hit", creature, "_on_Bullet_hit")):
#		self.connect("hit", creature, "_on_Bullet_hit", [])
	self.look_at(get_viewport().get_mouse_position())
	pass
	
func set_speed(value):
	speed = value

func _process(delta):
	translate((speed * motion * delta))
#	var collideCheck = move_and_collide(motion * delta)
#	#print(str(collideCheck))
#	if(collideCheck != null):
#		contact(collideCheck.collider)
#	var collideCheck2 = collideByPosition()
#	if collideCheck2:
#		print(str(collideCheck2))
##	if self.position.x > creature.position.x - creatureSprite.texture.get_width() and self.position.x < creature.position.x + creatureSprite.texture.get_width():
##		if self.position.y < creature.position.y + creatureSprite.texture.get_height() and self.position.y > creature.position.y - creatureSprite.texture.get_height():
##			contact(creature)
	if creature != null:
		if creature.overlaps_body(self):
			print("Well this sucks")
			destroy()
	distance = distance + 1
	pass
	
func loadCreatureSprite(res):
	creatureSprite = load(str(res))

func contact(body):
	print("Hit creature")
	emit_signal("hit", body.name, damage, critChance)
	emit_signal("hitUpdate")
	#if ricochet < 1:
	destroy()
	
func collideByPosition():
	if creature != null and creatureSprite != null:
		var r1from = mySprite.position
		var r1to = Vector2()
		r1to.x = r1from.x + mySprite.texture.get_width()
		r1to.y = r1from.y + mySprite.texture.get_height()
		var r2from = creature.position
		var r2to = Vector2()
		r2to.x = r2from.x + creatureSprite.get_width()
		r2to.y = r2from.y + creatureSprite.get_height()
		#thanks, kifhan from reddit
		return !(r2from.x >= r1to.x or r2to.x <= r1from.x or r2from.y >= r1to.y or r2to.y <= r1from.y) 
	else:
		#print("null AF")
		return false
	
func loadCreature(newCreature):
	creature = newCreature

func destroy():
    #play explosion animation and sound
    queue_free()
