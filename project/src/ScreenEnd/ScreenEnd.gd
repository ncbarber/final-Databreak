extends Control


func _ready() -> void:
	$BinaryParticle.visible = true
	$BinaryParticleInverse.visible = true


func _on_RestartButton_pressed() -> void:
	var _ignored := get_tree().change_scene("res://src/ScreenStart/ScreenStart.tscn")
	$BinaryParticle.visible = false
	$BinaryParticleInverse.visible = false
