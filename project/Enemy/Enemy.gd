extends KinematicBody2D
class_name Enemy



var run_speed := 100
var gravity := 0
var velocity := Vector2()
var is_moving_left := false
var playerVisble := true
var direction := 1
var rotation_position := 15
var state := "Idle" 
var player = null


func _ready() -> void:
	if direction == 1:
		$Sprite.flip_h = false
	var _connectionInvis = SignalManager.connect("player_invisible", self, "_on_player_invisible")
	var _connectionVis = SignalManager.connect("player_visible", self, "_on_player_visible")
	var _connectionBlink = SignalManager.connect("enemy_blink", self, "_blink_active")
	var _connectionUnBlink = SignalManager.connect("enemy_blink_over", self, "_blink_inactive")


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
			$Light.rotation_degrees = rotation_position
		"Chasing":
			$Light.rotation_degrees = ($Light.get_angle_to(player.position)-15)
			$Light/LightSprite.modulate = Color(1,0,0,0.5)
			run_speed = lerp(run_speed,475,delta/3)
			velocity = position.direction_to(player.position) * run_speed
			velocity = move_and_slide(velocity, Vector2(0, -1))


func _on_Light_body_entered(body) -> void:
	if playerVisble == true:
		player = body
		$Alarm.playing = true
		state = "Chasing"
	


func _on_Light_body_exited(_body) -> void:
	$DisengageTimer.start()


func _on_KillBox_body_entered(body) -> void:
	if body == player:
		SignalManager.emit_signal('game_over')


func _on_DisengageTimer_timeout() -> void:
	state = "Idle"
	$Alarm.playing = false
	$Light/LightSprite.modulate = Color(1,1,1,0.34)


func _on_player_invisible() -> void:
	playerVisble = false


func _on_player_visible() -> void:
	playerVisble = true


func _blink_active() -> void:
	$EnemyCollision.disabled = true
	$Light/LightCollision.disabled = true
	$KillBox/CollisionPolygon2D.disabled = true


func _blink_inactive() -> void:
	$EnemyCollision.disabled = false
	$Light/LightCollision.disabled = false
	$KillBox/CollisionPolygon2D.disabled = false
