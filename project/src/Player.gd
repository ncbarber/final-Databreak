extends KinematicBody2D


var jump_speed := -400
var run_speed := 100
var gravity := 300
var velocity := Vector2()
var is_jumping := false
var lives_remaining := 3


func _process(_delta):
	$Camera2D/LivesRemainingLabel.text = 'Lives Remaining: %d' % lives_remaining
	if Input.is_action_just_pressed("respawn"):
		lives_remaining -= 1


func _get_inputs() -> void:
	velocity.x = 0
	var right := Input.is_action_pressed('move_right')
	var left := Input.is_action_pressed('move_left')
	var jump := Input.is_action_just_pressed('jump')

	if right:
		velocity.x += run_speed
		if is_on_floor() or is_on_ceiling():
			$AnimatedSprite.animation = "walk"
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play()
	if left:
		velocity.x -= run_speed
		if is_on_floor() or is_on_ceiling():
			$AnimatedSprite.animation = "walk"
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play()
	if velocity.x == 0 and is_on_floor() or velocity.x == 0 and is_on_ceiling():
		$AnimatedSprite.animation = "idle"
		$AnimatedSprite.play()
	if jump and is_on_floor():
		$AnimatedSprite.animation = "jump"
		$AnimatedSprite.play()
		$JumpSound.play()
		is_jumping = true
		velocity.y = jump_speed
