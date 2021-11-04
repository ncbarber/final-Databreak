extends KinematicBody2D


var run_speed := 30
var gravity := 400
var velocity := Vector2()
var is_moving_left := false



func _ready():
	var randomNumber : RandomNumberGenerator = RandomNumberGenerator.new() 
	randomNumber.randomize()
	$PatrolTimer.wait_time=randomNumber.randi_range(2,7)


func _process(_delta) -> void:
	velocity.x = 0
	print($PatrolTimer.time_left)
	if $PatrolTimer.time_left<=0.1:
		is_moving_left = !is_moving_left
		$PatrolTimer.start()
	if is_moving_left == true:
		velocity.x -= run_speed
		
		
		
	if is_moving_left == false:
		velocity.x += run_speed
		
func _physics_process(delta) -> void:
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2(0, -1))


func _on_Light_body_entered(_body):
	var _game_over := get_tree().change_scene("res://src/ScreenEnd/ScreenEnd.tscn")
