extends Control


func _ready():
	$BinaryParticle.visible = true
	$BinaryParticleInverse.visible = true


func _on_StartButton_pressed():
	var _ignored := get_tree().change_scene("res://src/ScreenStart/ScreenStart.tscn")
	$BinaryParticle.visible = false
	$BinaryParticleInverse.visible = false
