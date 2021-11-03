extends KinematicBody2D


var jump_speed := -350
var run_speed := 300
var gravity := 400
var velocity := Vector2()
var is_jumping := false
var lives_remaining := 3
var animationDone := false


# func _process(_delta):
	# $Camera2D/LivesRemainingLabel.text = 'Lives Remaining: %d' % lives_remaining
	# if Input.is_action_just_pressed("respawn"):
	# 	lives_remaining -= 1


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


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "jump":
		# print(1)
		if $AnimatedSprite.frame == 5:
			# print(2)
			animationDone = true
