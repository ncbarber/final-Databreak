extends Area2D


func _on_Blink_body_entered(_body) -> void:
	RoomGlobals.ability_set('blink')
	queue_free()
