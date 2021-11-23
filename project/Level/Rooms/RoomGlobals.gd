extends Node


var loading = true;
var current_scene : Node2D;
var game_over : Control;
var room_array = [];
var current_index = 0;
var spawn_location = 1;
var rng = RandomNumberGenerator.new();
var ability = '' setget ability_set, ability_get


func ability_set(new_ability) -> void:
	ability = new_ability


func ability_get() -> String:
	return ability

func _start_game() -> void:
	var _connectionGameOver = SignalManager.connect("send_game_over", self, "_handle_Game_Over")
	var room_number = rng.randi_range(1, 4)
	room_array.push_back(room_number)
	_goto_scene(room_number)


func _next_room(direction) -> void:
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
		if(current_index == 0):
			return
		else:
			_goto_scene(room_array[current_index-1])
			current_index -= 1


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
	#var currentPath = get_tree().get_root().get_path()
	#var _c = ResourceLoader.load(currentPath)
	var newPath = "res://ScreenEnd/ScreenEnd.tscn"
	var n = ResourceLoader.load(newPath)
	game_over = n.instance()
	get_tree().get_root().add_child(game_over)
	get_tree().set_current_scene(game_over)
	current_scene.queue_free()
