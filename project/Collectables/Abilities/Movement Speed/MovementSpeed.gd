extends Area2D


func _on_MovementSpeed_body_entered(_body) -> void:
	RoomGlobals.ability_set('movement')
