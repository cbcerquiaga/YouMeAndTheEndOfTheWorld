extends Node2D

# class member variables go here, for example:
# var a = 2
var crosshair = load("res://Images/Crosshair.png")
#export (NodePath) var button_path
onready var surrenderButton = get_node("CombatHUD/Surrender Button")
onready var runButton = get_node("CombatHUD/Run Away Button")

func _ready():
	#set mouse cursor to combat crosshairs
	Input.set_custom_mouse_cursor(crosshair)
	#connect button signals
	self.get_node("Camera").make_current()
	surrenderButton.connect("pressed",self, "on_surrender_pressed")
	runButton.connect("pressed",self, "on_run_pressed")

func on_surrender_pressed():
	#TODO:
	#check how badly the enemy robs the player
	#check how badly the enemy maims the player and whether or not they kill them
	print("Uncle, uncle, uncle")
	
func on_run_pressed():
	#TODO:
	#check whether or not the player gets away
	#check whether or not the player takes damage, and how bad the damage is
	print("Ruuuun, Forrest, ruuuun")

func _pause():
	print("Game paused")
	get_tree().paused = true
	#$pause_popup.update()
	$pause_popup.show()
	
func _process(delta):
	if Input.is_action_pressed("pause"):
		_pause()

func _on_Bullet_hit():
	pass # replace with function body
