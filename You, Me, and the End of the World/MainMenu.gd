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
