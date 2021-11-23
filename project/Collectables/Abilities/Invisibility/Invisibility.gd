extends Node2D

signal collided

func _on_InvisCollision_body_entered(body) -> void:
	 emit_signal("collided")
