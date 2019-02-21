extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("Camera2D").make_current()


func _on_Combat_pressed():
	get_tree().change_scene("res://tscn files/Combat.tscn")


func _on_World1_pressed():
	get_tree().change_scene("res://tscn files/World1.tscn")


func _on_World2_pressed():
	get_tree().change_scene("res://tscn files/World2.tscn")

func _on_OpenWorld_pressed():
	get_tree().change_scene("res://tscn files/OpenWorld.tscn")
	
func _on_Fishing_pressed():
	get_tree().change_scene("res://tscn files/Fishing.tscn")
	
func _on_Hunting_pressed():
	get_tree().change_scene("res://tscn files/Hunting.tscn")
	
func _on_Farming_pressed():
	get_tree().change_scene("res://tscn files/Farming.tscn")
	
func _on_Hockey_pressed():
	get_tree().change_scene("res://tscn files/Hockey.tscn")
	
func _on_Music_pressed():
	get_tree().change_scene("res://tscn files/MusicMinigame.tscn")