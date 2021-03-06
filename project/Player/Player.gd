class_name Player
extends KinematicBody2D


var jump_speed := -1250
var run_speed := 375
var blink := 0
var gravity := 3200
var velocity := Vector2()
var door_location := Vector2()
var is_jumping := false
var is_crouched := false
var is_firstLoad := false
var lives_remaining := 3
var speed_boost := 0
var is_blocked := false
var player : KinematicBody2D
var usb : Area2D
var floppy : Area2D
var floppy_collected := 0
var usb_collected := 0
var timer := 0


func _ready() -> void:
	# On ready we set up the global connections that will communicate to change items on the HUD
	var _connectionFloppy = SignalManager.connect("handle_floppy", self, "_handle_Floppy")
	var _connectionUSB = SignalManager.connect("handle_usb", self, "_handle_USB")
	$Camera2D/HUD/DataToCollect.visible = true
	$Camera2D/HUD/DoorUnlocked.visible = false
	$Camera2D/HUD/Movement.visible = false
	$Camera2D/HUD/Invis.visible = false
	$Camera2D/HUD/Jump.visible = false
	$Camera2D/HUD/MovementLabel.visible = false
	$Camera2D/HUD/InvisLabel.visible = false
	$Camera2D/HUD/JumpLabel.visible = false
	$Camera2D/HUD/Counter.visible = false
	$Camera2D/HUD/Blink.visible = false
	$Camera2D/HUD/BlinkLabel.visible = false
#	RoomGlobals.ability_set('')


func _set_inputs() -> void:
	velocity.x = 0
	# Here we set up the input variables for all of our movement and the ability
	var right := Input.is_action_pressed('move_right')
	var left := Input.is_action_pressed('move_left')
	var crouch := Input.is_action_pressed('jump')
	var jump := Input.is_action_just_released("jump")
	var ability := Input.is_action_just_pressed("ability")

	if RoomGlobals.ability_get() == 'movement':
			speed_boost = 200
	else:
		speed_boost = 0

	if right:
		$AnimatedSprite.flip_h = false
		if is_crouched != true:
			velocity.x += (run_speed + speed_boost + blink)
			if is_on_floor():
				$AnimatedSprite.animation = "walk"
				$AnimatedSprite.play()
	if left:
		$AnimatedSprite.flip_h = true
		if is_crouched != true:
			velocity.x -= (run_speed + speed_boost + blink) 
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
		jump_speed = -1250
		if is_jumping == false:
			if $AnimatedSprite.frame == 15:
				jump_speed = -1750 
				get_node("AnimatedSprite").set_modulate(Color(1, .5, .5))
			if is_crouched == false:
				jump_speed = -1250
				get_node("AnimatedSprite").set_modulate(Color(1, 1, 1))
		
		
	if jump and is_on_floor():
		if RoomGlobals.ability_get() == 'jump' && !is_blocked:
			jump_speed -= 500
			is_blocked = true
			$AbilityCooldown.start()
		$AnimatedSprite.animation = "jump"
		$AnimatedSprite.play()
		is_crouched = false
		is_jumping = true
		velocity.y = jump_speed
		
	if !is_on_floor():
		get_node("AnimatedSprite").set_modulate(Color(1, 1, 1))
		$AnimatedSprite.animation = "jump"
		$AnimatedSprite.play()
		
	if ability && !is_blocked:
		if RoomGlobals.ability_get() == 'invisible':
			is_blocked = true
			modulate.a8 = 50
			SignalManager.emit_signal("invisible")
			$InvisibilityTimer.start()
			$AbilityCooldown.start()
			
		if RoomGlobals.ability_get() == 'blink':
			is_blocked = true
			blink = 12000
			SignalManager.emit_signal("blink")
			$BlinkTimer.start()
			$AbilityCooldown.start()

	# Here we check what ability we currently have, and then update the HUD as needed as well as handle 
	# when an ability is used, like invisibility and the jump boost
	if RoomGlobals.ability_get() == 'jump':
		$Camera2D/HUD/Movement.visible = false
		$Camera2D/HUD/Invis.visible = false
		$Camera2D/HUD/Jump.visible = true
		$Camera2D/HUD/MovementLabel.visible = false
		$Camera2D/HUD/InvisLabel.visible = false
		$Camera2D/HUD/BlinkLabel.visible = false
		$Camera2D/HUD/Blink.visible = false
		if is_blocked:
			$Camera2D/HUD/Jump.modulate.a8 = 50
			$Camera2D/HUD/Counter.visible = true
			$Camera2D/HUD/JumpLabel.visible = false
		if !is_blocked:
			$Camera2D/HUD/Jump.modulate.a8 = 255
			$Camera2D/HUD/Counter.visible = false
			$Camera2D/HUD/JumpLabel.visible = true
			
	if RoomGlobals.ability_get() == 'invisible':
		$Camera2D/HUD/Movement.visible = false
		$Camera2D/HUD/Invis.visible = true
		$Camera2D/HUD/Jump.visible = false
		$Camera2D/HUD/MovementLabel.visible = false
		$Camera2D/HUD/JumpLabel.visible = false
		$Camera2D/HUD/BlinkLabel.visible = false
		$Camera2D/HUD/Blink.visible = false
		if is_blocked:
			$Camera2D/HUD/Invis.modulate.a8 = 50
			$Camera2D/HUD/Counter.visible = true
			$Camera2D/HUD/InvisLabel.visible = false
		if !is_blocked:
			$Camera2D/HUD/Invis.modulate.a8 = 255
			$Camera2D/HUD/Counter.visible = false
			$Camera2D/HUD/InvisLabel.visible = true
		
	if RoomGlobals.ability_get() == 'movement':
		$Camera2D/HUD/Movement.visible = true
		$Camera2D/HUD/Invis.visible = false
		$Camera2D/HUD/Jump.visible = false
		$Camera2D/HUD/MovementLabel.visible = true
		$Camera2D/HUD/InvisLabel.visible = false
		$Camera2D/HUD/JumpLabel.visible = false
		$Camera2D/HUD/BlinkLabel.visible = false
		$Camera2D/HUD/Counter.visible = false
		$Camera2D/HUD/Blink.visible = false
		
	if RoomGlobals.ability_get() == 'blink':
		$Camera2D/HUD/Movement.visible = false
		$Camera2D/HUD/Invis.visible = false
		$Camera2D/HUD/Jump.visible = false
		$Camera2D/HUD/Blink.visible = true
		if is_blocked:
			$Camera2D/HUD/Blink.modulate.a8 = 50
			$Camera2D/HUD/Counter.visible = true
			$Camera2D/HUD/BlinkLabel.visible = false
		if !is_blocked:
			$Camera2D/HUD/Blink.modulate.a8 = 255
			$Camera2D/HUD/Counter.visible = false
			$Camera2D/HUD/BlinkLabel.visible = true
		
	if RoomGlobals.ability_get() == '':
		$Camera2D/HUD/BlinkLabel.visible = false
		$Camera2D/HUD/Blink.visible = false


func _physics_process(delta) -> void:
	_set_inputs()
	if is_firstLoad and $Camera2D/HUD/Blink.visible == true and $Camera2D/HUD/BlinkLabel.visible == true:
		$Camera2D/HUD/Blink.visible = false
		$Camera2D/HUD/BlinkLabel.visible = false
		is_firstLoad = false
	timer = $AbilityCooldown.time_left
	$Camera2D/HUD/Counter.text = "Ability Ready in: %d s" % timer
	if floppy_collected == 2 and usb_collected == 1:
		SignalManager.emit_signal("unlock")
		usb_collected = 0
		floppy_collected = 0
		$Camera2D/HUD/DataToCollect.visible = false
		$Camera2D/HUD/DoorUnlocked.visible = true
		
	velocity.y += gravity * delta
	if is_jumping and is_on_floor() or is_jumping and is_on_ceiling():
		is_jumping = false
		
	velocity = move_and_slide(velocity, Vector2(0, -1))

func _on_InvisibilityTimer_timeout() -> void:
	modulate.a8 = 255
	SignalManager.emit_signal("visible")


func _on_AbilityCooldown_timeout() -> void:
	is_blocked = false


func _handle_USB() -> void:
	usb_collected += 1
	$Camera2D/HUD/USB.visible = false


func _handle_Floppy() -> void:
	floppy_collected += 1
	if floppy_collected == 1:
		$Camera2D/HUD/Floppy.visible = false
	elif floppy_collected == 2:
		$Camera2D/HUD/Floppy2.visible = false
	

func _on_BlinkTimer_timeout() -> void:
	blink = 0
	SignalManager.emit_signal("blink_over")
