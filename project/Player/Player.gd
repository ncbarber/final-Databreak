extends KinematicBody2D


var jump_speed := -1250
var run_speed := 375
var gravity := 3200
var velocity := Vector2()
var is_jumping := false
var lives_remaining := 3


func _set_inputs() -> void:
	velocity.x = 0
	var right := Input.is_action_pressed('move_right')
	var left := Input.is_action_pressed('move_left')
	var jump := Input.is_action_just_pressed('jump')

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


func _physics_process(delta) -> void:
	_set_inputs()
	velocity.y += gravity * delta
	if is_jumping and is_on_floor() or is_jumping and is_on_ceiling():
		is_jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
