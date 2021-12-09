extends Control


func _ready() -> void:
	$BinaryParticle.visible = true
	$BinaryParticleInverse.visible = true


func _on_RestartButton_pressed() -> void:
	var _ignored := get_tree().change_scene("res://ScreenStart/ScreenStart.tscn")
	queue_free()
	$BinaryParticle.visible = false
	$BinaryParticleInverse.visible = false
