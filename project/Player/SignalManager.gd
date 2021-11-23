extends Node


signal floppy_entered
signal usb_entered

#signal invis_entered
#signal jump_entered
#signal movement_entered

signal handle_floppy
signal handle_usb


func _ready():
	var _connectionFloppy = connect('floppy_entered', self, '_on_floppy_entered')
	var _connectionUSB = connect('usb_entered', self, '_on_usb_entered')
	emit_signal('floppy_entered')
	emit_signal('usb_entered')


func _on_floppy_entered():
	emit_signal('handle_floppy')


func _on_usb_entered():
	emit_signal('handle_usb')
