extends CanvasLayer



func _ready():
	pass # Replace with function body.


func _process(_delta) -> void:
	if Input.is_action_just_pressed("menu"):
		$MenuButton.visible = !$MenuButton.visible
		


func _on_MenuButton_pressed() -> void:
	var _ignored := get_tree().change_scene("res://ScreenStart/ScreenStart.tscn")
