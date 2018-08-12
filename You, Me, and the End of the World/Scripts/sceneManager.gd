extends Node2D

const marginForCameraToZoomOut = 300
#const slowdownOfZoomOut = 5
const maxZoomOutScale = 0.7
const minZoomInScale = 1.0

# class member variables go here, for example:
var isp1Playing
var isp2Playing
var cooldown = true;
var cooldown2 = true;
var timer1 = Timer.new()
var timer2 = Timer.new()
onready var player1 = get_node("walls/player1")
onready var player2 = get_node("walls/player2")
onready var screensize = Vector2(get_viewport().size.x, get_viewport().size.y)


func _ready():
	isp1Playing = true
	isp2Playing = true
	#Handling Timer
	timer1.connect("timeout",self,"_on_timer_timeout")
	timer2.connect("timeout", self, "_on_timer2_timeout")
	add_child(timer1)
	add_child(timer2)
	_start_timer1()
	_start_timer2()
	#Handling Camera
	update_camera()

#Function to start the timer at 1 seconds
func _start_timer1():
	if !timer1.time_left > 0:
		timer1.wait_time = 1
		timer1.start() #to start

#Function to start the second timer at 1 seconds
func _start_timer2():
	if !timer2.time_left > 0:
		timer2.wait_time = 1
		timer2.start() #to start

#The function to handle when the timer times out
func _on_timer_timeout():
	cooldown = false

func _on_timer2_timeout():
	cooldown2 = false

func _pause():
	print("Game paused")
	get_tree().paused = true
	$pause_popup.rect_global_position = (-(player1.global_position + player2.global_position)/(2) + (screensize/(2)))
	$pause_popup.update()

	$pause_popup.show()
	

func _process(delta):
	if Input.is_action_pressed("p1_dropout") and !cooldown:
		if(isp1Playing && isp2Playing):
			cooldown = true
			isp1Playing = false
			_start_timer1()
		elif(!isp1Playing):
			cooldown = true
			isp1Playing = true
			_start_timer1()
	if Input.is_action_pressed("p2_dropout") and !cooldown2:
		if(isp1Playing && isp2Playing):
			cooldown2 = true
			isp2Playing = false
			_start_timer2()
		elif(!isp2Playing):
			cooldown2 = true
			isp2Playing = true
			_start_timer2()
	if Input.is_action_pressed("pause"):
		_pause()
	pass

#func recenter_camera():
#	Working camera focusing on two players
#	var canvas_transform = get_viewport().get_canvas_transform()
#	canvas_transform[2] = (-(player1.global_position + player2.global_position)/2 + (screensize/2))
#	get_viewport().set_canvas_transform(canvas_transform)

func update_camera():
#	#Get the change of p1 and p2's location compared to last update_camera call
#	var player_distance = (screensize/4)/(player2.position - player1.position)
#	var maxValueX = abs(player_distance.x)
#	var maxValueY = abs(player_distance.y)
#	print(maxValueX)
#	if maxValueX > minZoomInScale:
#		maxValueX = minZoomInScale
#	elif maxValueX < maxZoomOutScale:
#		maxValueX = maxZoomOutScale
#	if maxValueY > minZoomInScale:
#		maxValueY = minZoomInScale
#	elif maxValueY < maxZoomOutScale:
#		maxValueY = maxZoomOutScale
#	
#	#Update player's last positions to their current position
#	#Get the current canvas transform
	var canvas_transform = get_viewport().get_canvas_transform()
#	#Update the canvas with the player's offset
#	canvas_transform[0] = Vector2(maxValueX,0)
#	canvas_transform[1] = Vector2(0, maxValueY)
	canvas_transform[2] = (-(player1.global_position + player2.global_position)/(2) + (screensize/(2)))
	get_viewport().set_canvas_transform(canvas_transform)

	
	#DEBUG
#	print('last_player1_pos: ', last_player1_pos)
#	print('last_player2_pos: ', last_player2_pos)
#	print('player1.global_position: ', player1.global_position)
#	print('player2.global_position: ', player2.global_position)
#	print('distance between players: ', (player1.global_position-player2.global_position))
#	print(player_distance.x, ' ' , player_distance.y)
#	print(canvas_transform.get_scale())
#	print(maxValue)
	
#func save():
#	var save_dict = {
#		"filename" : get_filename(),
#		"parent" : get_parent().get_path(),
#		"p1Pos_x" : player1.position.x,
#		"p1Pos_y" : player1.position.y,
#		"p2Pos_x" : player2.postion.x,
#		"p2Pos_y" : player2.position.y,
#		"p1Properties" : player1.playerProperties,
#		"p2Properties" : player2.playerProperties
#	}
#	return save_dict
#
#func save_game():
#	var save_game = File.new()
#	save_game.open("user://savegame.save", File.WRITE)
#	var save_nodes = get_tree().get_nodes_in_group("Persist")
#	for i in save_nodes:
#		var node_data = i.call("save");
#		save_game.store_line(to_json(node_data))
#	save_game.close()
#
## Note: This can be called from anywhere inside the tree. This function is path independent.
#func load_game():
#    var save_game = File.new()
#    if not save_game.file_exists("user://save_game.save"):
#        return # Error! We don't have a save to load.
#
#    # We need to revert the game state so we're not cloning objects during loading. This will vary wildly depending on the needs of a project, so take care with this step.
#    # For our example, we will accomplish this by deleting savable objects.
#    var save_nodes = get_tree().get_nodes_in_group("Persist")
#    for i in save_nodes:
#        i.queue_free()
#
#    # Load the file line by line and process that dictionary to restore the object it represents
#    save_game.open("user://savegame.save", File.READ)
#    while not save_game.eof_reached():
#        var current_line = parse_json(save_game.get_line())
#        # First we need to create the object and add it to the tree and set its position.
#        var new_object = load(current_line["filename"]).instance()
#        get_node(current_line["parent"]).add_child(new_object)
#        new_object.position = Vector2(current_line["pos_x"], current_line["pos_y"]))
#        # Now we set the remaining variables.
#        for i in current_line.keys():
#            if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
#                continue
#            new_object.set(i, current_line[i])
#    save_game.close()