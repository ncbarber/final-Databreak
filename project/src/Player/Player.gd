extends KinematicBody2D


var jump_speed := -350
var run_speed := 300
var gravity := 400
var velocity := Vector2()
var is_jumping := false
var lives_remaining := 3
var animationDone := false


func _ready():
	var level : Node2D = load("res://src/Level/Level.tscn").instance()
	var _usb_connection := level.connect("usb_HUD_trigger", self, "usb_collected")
	var _floppy_connection := level.connect("floppy_HUD_trigger", self, "floppy_collected", [level])


func _get_inputs() -> void:
	velocity.x = 0
	var right := Input.is_action_pressed('move_right')
	var left := Input.is_action_pressed('move_left')
	var jump := Input.is_action_just_pressed('jump')
	#var jumpFinished := Input.is_action_just_released('jump')

	if right:
		velocity.x += run_speed
		if is_on_floor():
			$AnimatedSprite.animation = "walk"
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play()
	if left:
		velocity.x -= run_speed
		if is_on_floor():
			$AnimatedSprite.animation = "walk"
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play()
	if velocity.x == 0 and is_on_floor():
		$AnimatedSprite.animation = "idle"
		$AnimatedSprite.play()
		
	if jump and is_on_floor():
		$AnimatedSprite.animation = "jump"
		$AnimatedSprite.play()
		is_jumping = true
		velocity.y = jump_speed

	# Test code for getting jump animation to function
	# if jump and is_on_floor():
		# if animationDone == true and is_on_floor():


func _physics_process(delta) -> void:
	_get_inputs()
	velocity.y += gravity * delta
	if is_jumping and is_on_floor() or is_jumping and is_on_ceiling():
		is_jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))


func usb_HUD_trigger():
	$Camera2D/HUD/USB.visible = false


func floppy_HUD_trigger(num):
	if num == 1:
		$Camera2D/HUD/Floppy.visible = false
	elif num == 2:
		$Camera2D/HUD/Floppy2.visible = false
	elif num == 3:
		$Camera2D/HUD/Floppy3.visible = false


#func _on_AnimatedSprite_animation_finished():
#	if $AnimatedSprite.animation == "jump":
#		# print(1)
#		if $AnimatedSprite.frame == 5:
#			# print(2)
#			animationDone = true
