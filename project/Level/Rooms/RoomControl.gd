extends Node2D


func _ready() -> void:
	var scene = get_tree().current_scene
	RoomGlobals.current_scene = scene


func _on_Button_pressed() -> void:
	RoomGlobals._start_game()
