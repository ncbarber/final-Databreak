extends Node2D

const SPAWN_POSITION := Vector2(496,460)
const USB_POSITION := Vector2(8, 380)
const FLOPPY_POSITION := Vector2(100, 380)

var player : KinematicBody2D
var usb : Area2D
var floppy : Area2D


func _ready():
	_make_player()
	_make_USB()
	_make_Floppy_Disk()


func _make_player() -> void:
	player = load("res://src/Player/Player.tscn").instance()
	player.position = SPAWN_POSITION
	call_deferred("add_child", player)

func _make_USB() -> void:
	usb = load("res://src/Collectables/Data/USB.tscn").instance()
	usb.position = USB_POSITION
	call_deferred("add_child", usb)

func _make_Floppy_Disk() -> void:
	floppy = load("res://src/Collectables/Data/FloppyDisk.tscn").instance()
	floppy.position = FLOPPY_POSITION
	call_deferred("add_child", floppy)
