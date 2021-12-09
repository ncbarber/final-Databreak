extends Area2D


#func _ready() -> void:
#	var player = get_node("/root/RoomTwo/Player")
#	var _unused = player.connect("floppy_entered", player, "_on_Floppy_Entered")


func _on_FloppyDisk_body_entered(_body) -> void:
	SignalManager.emit_signal("floppy_entered")
	queue_free()
