extends Node2D


func _on_InvisCollision_body_entered(_body) -> void:
	RoomGlobals.ability_set('invisible')
	$Collect.play()
	queue_free()
