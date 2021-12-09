extends Node2D


var is_door_open := true;
var startup = true;

onready var player := $Player;
onready var enemy := $Enemy;

func _ready():
	$Enemy.tutorial = true
	player._handle_Floppy()
	player._handle_Floppy()
	var scene = get_tree().current_scene
	RoomGlobals.current_scene = scene

func _on_DoorArea_body_entered(body):
	if body is Player && is_door_open:
		player.position = Vector2(1271, 7)
		is_door_open = false


func _on_SpawnArea_body_entered(body):
	if body is Player && is_door_open:
		player.position = Vector2(1046, 7)
		is_door_open = false


func _on_DoorArea_body_exited(_body):
	is_door_open = true


func _on_SpawnArea_body_exited(_body):
	is_door_open = true


func _on_Door2Area_body_entered(_body):
	if(startup):
		startup=false
	else:
		RoomGlobals._start_game()
		queue_free()
