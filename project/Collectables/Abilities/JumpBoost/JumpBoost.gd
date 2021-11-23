extends Area2D


func _on_JumpBoost_body_entered(body):
	RoomGlobals.ability_set('jump')
