extends KinematicBody2D

var damage = 100 #default damage
var critChance = .2 #default critical chance
var speed = 500 #default speed 500
var motion = Vector2(2,0)

onready var creature = self.get_parent().get_node("Creature")
onready var creatureSprite = self.get_parent().get_node("Creature/Sprite")

signal hit
signal hitUpdate

func _ready():
	set_process(true)
	if(!self.is_connected("hit", creature, "_on_Bullet_hit")):
		self.connect("hit", creature, "_on_Bullet_hit", [])
	self.look_at(get_viewport().get_mouse_position())
	pass
	
func set_speed(value):
	speed = value

func _process(delta):
	translate((speed * motion * delta))
	var collideCheck = move_and_collide(motion * delta)
	#print(str(collideCheck))
	if(collideCheck != null):
		contact(collideCheck.collider)
#	if self.position.x > creature.position.x - creatureSprite.texture.get_width() and self.position.x < creature.position.x + creatureSprite.texture.get_width():
#		if self.position.y < creature.position.y + creatureSprite.texture.get_height() and self.position.y > creature.position.y - creatureSprite.texture.get_height():
#			contact(creature)
	pass

func contact(body):
	print("Hit creature")
	emit_signal("hit", body.name, damage, critChance)
	emit_signal("hitUpdate")
	#if ricochet < 1:
	destroy()

func destroy():
    #play explosion animation and sound
    queue_free()
