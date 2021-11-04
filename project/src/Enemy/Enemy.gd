extends KinematicBody2D

signal player_hit 


var run_speed := 30
var gravity := 500
var velocity := Vector2()
var is_moving_left := false
var direction = 1


var player : KinematicBody2D


func _ready():
	if direction == 1:
		$Sprite.flip_h = false


func _physics_process(delta) -> void:
	if $PatrolTimer.time_left == 0:
		$PatrolTimer.start()
		direction = direction * -1
		$Sprite.flip_h = !$Sprite.flip_h
	
	velocity.y += gravity * delta
	velocity.x = run_speed * direction
	velocity = move_and_slide(velocity, Vector2(0, -1))


func _on_Light_body_entered(body):
	emit_signal("player_hit", body)
