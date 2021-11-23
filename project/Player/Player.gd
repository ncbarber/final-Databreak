extends KinematicBody2D
class_name Player

var jump_speed := -1250
var run_speed := 375
var gravity := 3200
var velocity := Vector2()
var is_jumping := false
var is_crouched := false
var lives_remaining := 3

func _set_inputs() -> void:
	velocity.x = 0
	var right := Input.is_action_pressed('move_right')
	var left := Input.is_action_pressed('move_left')
	var crouch := Input.is_action_pressed('jump')
	var jump := Input.is_action_just_released("jump")

	if right:
		$AnimatedSprite.flip_h = false
		if is_crouched != true:
			velocity.x += run_speed
			if is_on_floor():
				$AnimatedSprite.animation = "walk"
				$AnimatedSprite.play()
	if left:
		$AnimatedSprite.flip_h = true
		if is_crouched != true:
			velocity.x -= run_speed
			if is_on_floor():
				$AnimatedSprite.animation = "walk"
				$AnimatedSprite.play()
	if velocity.x == 0 and is_on_floor():
		if is_crouched != true:
			$AnimatedSprite.animation = "idle"
			$AnimatedSprite.play()
		
	if crouch and is_on_floor():
		$AnimatedSprite.animation = "crouch"
		$AnimatedSprite.play()
		is_crouched = true
		
	if jump and is_on_floor():
		$AnimatedSprite.animation = "jump"
		$AnimatedSprite.play()
		is_crouched = false
		is_jumping = true
		velocity.y = jump_speed
		
	if !is_on_floor():
		$AnimatedSprite.animation = "jump"
		$AnimatedSprite.play()


func _physics_process(delta) -> void:
	_set_inputs()
	velocity.y += gravity * delta
	if is_jumping and is_on_floor() or is_jumping and is_on_ceiling():
		is_jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
