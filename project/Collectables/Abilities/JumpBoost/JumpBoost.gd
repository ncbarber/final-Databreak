extends Area2D


func _on_JumpBoost_body_entered(_body) -> void:
	RoomGlobals.ability_set('jump')
