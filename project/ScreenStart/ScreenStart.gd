extends Control


func _ready() -> void:
	$BinaryParticle.visible = true
	$BinaryParticleInverse.visible = true
	var scene = get_tree().current_scene
	RoomGlobals.current_scene = scene


func _on_StartButton_pressed() -> void:
	var _ignored := get_tree().change_scene("res://Tutorial/Tutorial.tscn")
	$BinaryParticle.visible = false
	$BinaryParticleInverse.visible = false
	queue_free()
