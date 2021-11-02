extends Node2D

const SPAWN_POSITION := Vector2(496,460)

var player : KinematicBody2D


func _ready():
	_make_player()


func _make_player() -> void:
	player = load("res://src/Player.tscn").instance()
	player.position = SPAWN_POSITION
	call_deferred("add_child", player)
