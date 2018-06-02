extends PopupMenu


func _on_pause_popup_resume_pressed():
    $pause_popup.hide()
    get_tree().paused = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_pressed("pause"): ##|| resume clicked
		_on_pause_popup_resume_pressed()
	pass
