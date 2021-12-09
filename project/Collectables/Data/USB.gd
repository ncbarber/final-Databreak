extends Area2D




func _on_USB_body_entered(_body) -> void:
	SignalManager.emit_signal("usb_entered")
	queue_free()
	# Play sound
