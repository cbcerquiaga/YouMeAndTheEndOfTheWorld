extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var dialogPopup = get_node("/root/Root/dialog_popup")


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func handle_item_pickup(player):
	var dialog = [
	"Text 1",
	"Text 2",
	"Text 3"
	]
	self.dialogPopup.load_Dialog(dialog)
	self.dialogPopup.update()