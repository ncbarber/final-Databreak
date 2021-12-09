extends Node


signal floppy_entered
signal usb_entered

signal game_over
signal send_game_over

signal unlock
signal door_unlocked

signal invisible
signal visible
signal player_invisible
signal player_visible

signal handle_floppy
signal handle_usb


signal blink
signal blink_over
signal enemy_blink
signal enemy_blink_over


func _ready() -> void:
	var _connectionFloppy = connect('floppy_entered', self, '_on_floppy_entered')
	var _connectionUSB = connect('usb_entered', self, '_on_usb_entered')
	var _connectionGameOver = connect('game_over', self, '_on_game_over')
	var _connectionUnlock = connect('unlock', self, '_on_unlock')
	var _connectionInvis = connect("invisible", self, '_handle_invisible')
	var _connectionVis = connect("visible", self, '_handle_visible')
	var _connectionBlink = connect("blink", self, '_handle_blink')
	var _connectionBlinkOver = connect("blink_over", self, '_handle_blink_over')
	emit_signal('floppy_entered')
	emit_signal('usb_entered')
	emit_signal('game_over')
	emit_signal('unlock')
	emit_signal("invisible")
	emit_signal("visible")


func _on_floppy_entered() -> void:
	emit_signal('handle_floppy')


func _on_usb_entered() -> void:
	emit_signal('handle_usb')


func _on_game_over() -> void:
	emit_signal("send_game_over")


func _on_unlock() -> void:
	emit_signal('door_unlocked')


func _handle_invisible() -> void:
	emit_signal("player_invisible")


func _handle_visible() -> void:
	emit_signal("player_visible")

func _handle_blink() -> void:
	emit_signal('enemy_blink')

func _handle_blink_over() -> void:
	emit_signal('enemy_blink_over')
