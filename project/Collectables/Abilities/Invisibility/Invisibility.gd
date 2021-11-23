extends Node2D


func _on_InvisCollision_body_entered(body) -> void:
	 RoomGlobals.ability_set('invisible')
