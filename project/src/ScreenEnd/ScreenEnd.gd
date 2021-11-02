extends Control


func _on_RestartButton_pressed():
	var _ignored := get_tree().change_scene("res://src/ScreenStart/ScreenStart.tscn")
