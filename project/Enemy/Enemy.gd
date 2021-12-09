extends KinematicBody2D
class_name Enemy

signal player_hit 


var run_speed := 100
var gravity := 0
var velocity := Vector2()
var is_moving_left := false
var direction := 1
var rotation_position := 15
var state := "Idle"
<<<<<<< Updated upstream
var pre_stun_y_position := 0


=======
>>>>>>> Stashed changes
var player = null


func _ready() -> void:
	if direction == 1:
		$Sprite.flip_h = false


func _physics_process(delta) -> void:
	match state:
		"Idle":
			run_speed = 100
			if $PatrolTimer.time_left == 0:
				$PatrolTimer.start()
				direction = direction * -1
				$Sprite.flip_h = !$Sprite.flip_h
				$Light.scale.x = $Light.scale.x*-1
				rotation_position = rotation_position * -1
				$Light.rotation_degrees = $Light.rotation_degrees*-1
			velocity.y = 0
			velocity.x = run_speed * direction
			velocity = move_and_slide(velocity, Vector2(0, -1))
		"Chasing":
			$Light.rotation_degrees = ($Light.get_angle_to(player.position)-15)
			$Light/LightSprite.modulate = Color(1,0,0,0.5)
			run_speed = lerp(run_speed,475,delta/3)
			velocity = position.direction_to(player.position) * run_speed
			velocity = move_and_slide(velocity, Vector2(0, -1))
		"Stunned":
			velocity.y = 0
			velocity.x = 0
			velocity = move_and_slide(velocity, Vector2(0, -1))
<<<<<<< Updated upstream


func _on_Light_body_entered(body) -> void:
	player = body
	$Alarm.playing = true
	state = "Chasing"
	


func _on_Light_body_exited(_body)-> void:
	$DisengageTimer.start()
	

func _on_KillBox_body_entered(body)-> void:
	emit_signal("player_hit", body)
=======
			


func _on_Light_body_entered(body) -> void:
	if playerVisble == true and state != "Stunned":
		player = body
		$Alarm.playing = true
		state = "Chasing"
	


func _on_Light_body_exited(_body) -> void:
	if _body is KinematicBody2D and state != "Stunned":
		$DisengageTimer.start()


func _on_KillBox_body_entered(body) -> void:
	if body is KinematicBody2D and state != "Stunned":
		SignalManager.emit_signal('game_over')
>>>>>>> Stashed changes


func _on_DisengageTimer_timeout() -> void:
	state = "Idle"
	$Alarm.playing = false
	$Light/LightSprite.modulate = Color(1,1,1,0.34)


func _on_StunTimer_timeout() -> void:
	print("unstunned!")
	state = "Idle"


<<<<<<< Updated upstream
func _on_StunCollision_body_exited(body) -> void:
	player = body
	print("Stunned!")
	state = "Stunned"
	$StunTimer.start()
=======
func _blink_inactive() -> void:
	$EnemyCollision.disabled = false
	$Light/LightCollision.disabled = false
	$KillBox/CollisionPolygon2D.disabled = false


func _on_Area2D_body_entered(body) -> void:
	if body is KinematicBody2D:
		state = "Stunned"
		$StunTimer.start()
		$Alarm.playing = false
		$Light/LightSprite.modulate = Color(1,1,1,0.34)
		$StunEffect.visible = true


func _on_StunTimer_timeout() -> void :
	state = "Idle"
	$StunEffect.visible = false
>>>>>>> Stashed changes
