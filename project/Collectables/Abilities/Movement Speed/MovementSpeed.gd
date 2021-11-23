extends Area2D


func _on_MovementSpeed_body_entered(body):
	RoomGlobals.ability_set('movement')
