extends Node2D


const SPAWN_POSITION := Vector2(335,-565)
const DOOR_POSITION := Vector2(3756,-45)


var player : KinematicBody2D
var spawn : Vector2


func _ready() -> void:
	RoomGlobals.loading = true
	if(RoomGlobals.spawn_location):
		spawn = SPAWN_POSITION
	else:
		spawn = DOOR_POSITION
	
	_make_player()


func _make_player() -> void:
	player = load("res://Player/Player.tscn").instance()
	player.position = spawn
	call_deferred("add_child", player)


func _on_SpawnArea_body_entered(_body) -> void:
	if RoomGlobals.loading:
		return
	else:
		RoomGlobals.next_room(0)


func _on_SpawnArea_body_exited(_body) -> void:
	RoomGlobals.loading = false


func _on_DoorArea_body_entered(_body) -> void:
	if RoomGlobals.loading:
		return
	else:
		RoomGlobals.next_room(1)


func _on_DoorArea_body_exited(_body) -> void:
	RoomGlobals.loading = false
