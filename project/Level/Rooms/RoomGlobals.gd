extends Node


var loading = true;
var unlock = false;
var current_scene ;
var game_over : Control;
var room_array = [];
var current_index = 0;
var spawn_location = 1;
var rng = RandomNumberGenerator.new();
var ability = '' setget ability_set, ability_get
var is_startup = true


func _ready() -> void:
	var _connectionGameOver = SignalManager.connect("send_game_over", self, "_handle_Game_Over")
	var _connectionMainMenu = SignalManager.connect("send_main_menu", self, "_handle_Main_Menu")
	var _connectionUnlock = SignalManager.connect("door_unlocked", self, "_handle_unlock")


func ability_set(new_ability) -> void:
	ability = new_ability


func ability_get() -> String:
	return ability


func _start_game() -> void:
	unlock = false
	rng.randomize()
	current_index = 0
	var room_number = rng.randi_range(1, 4)
	room_array.push_back(room_number)
	_goto_scene(room_number)


func _next_room(direction) -> void:
	ability_set('')
	spawn_location = direction
	if(direction):
		var room_number;
		if(current_index == room_array.size()-1):
			room_number = rng.randi_range(1, 4)
			room_array.push_back(room_number)
		else:
			room_number = room_array[current_index+1]
		current_index += 1
		_goto_scene(room_number)
	else:
		return
#		if(current_index == 0):
#			return
#		else:
#			_goto_scene(room_array[current_index-1])
#			current_index -= 1


func _goto_scene(room_number) -> void:
	print('switching to room: ' + str(room_number))
	print('Room array: ' + str(room_array))
	loading = true;
	
	var path = "res://Level/Rooms/";
	if (room_number == 1):
		path += "RoomOne/RoomOne.tscn"
	elif (room_number == 2):
		path += "RoomTwo/RoomTwo.tscn"
	elif (room_number == 3):
		path += "RoomThree/RoomThree.tscn"
	else:
		path += "RoomFour/RoomFour.tscn"
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path) -> void:

	if(current_scene != null):
		current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)
	
	
func _handle_Game_Over() -> void:
	if(!is_startup):
		call_deferred('_deferred_goto_scene', "res://ScreenEnd/ScreenEnd.tscn")
	else:
		is_startup=false
	room_array.clear()
	ability_set('')
	
	
func _handle_Main_Menu() -> void:
	if(!is_startup):
		call_deferred('_deferred_goto_scene', "res://ScreenStart/ScreenStart.tscn")
	else:
		is_startup=false
	room_array.clear()
	ability_set('')


func _handle_unlock() -> void:
	unlock = true
