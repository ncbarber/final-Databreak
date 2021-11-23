extends Node


signal floppy_entered
signal usb_entered

signal game_over
signal send_game_over

signal handle_floppy
signal handle_usb


func _ready() ->void:
	var _connectionFloppy = connect('floppy_entered', self, '_on_floppy_entered')
	var _connectionUSB = connect('usb_entered', self, '_on_usb_entered')
	var _connectionGameOver = connect('game_over', self, '_on_game_over')
	emit_signal('floppy_entered')
	emit_signal('usb_entered')
	emit_signal('game_over')


func _on_floppy_entered() -> void:
	emit_signal('handle_floppy')


func _on_usb_entered() -> void:
	emit_signal('handle_usb')


func _on_game_over() -> void:
	emit_signal("send_game_over")
	
