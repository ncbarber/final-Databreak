extends Node2D


const SPAWN_POSITION := Vector2(335,-565)
const DOOR_POSITION := Vector2(3756,-45)


var player : KinematicBody2D
var spawn : Vector2


func _ready() -> void:
	RoomGlobals.loading = true
	spawn = SPAWN_POSITION
	_set_up_Enemies()
	_set_up_ability()
	_set_up_floppy()
	_make_player()


func _make_player() -> void:
	player = load("res://Player/Player.tscn").instance()
	player.position = spawn
	call_deferred("add_child", player)


func _on_SpawnArea_body_entered(_body) -> void:
	if RoomGlobals.loading:
		return
	else:
		return
#		RoomGlobals._next_room(0)


func _on_SpawnArea_body_exited(_body) -> void:
	RoomGlobals.loading = false
	RoomGlobals._next_room(0)


func _on_DoorArea_body_entered(_body) -> void:
	if RoomGlobals.loading:
		return
	elif RoomGlobals.unlock == true:
		RoomGlobals._next_room(1)
		RoomGlobals.unlock = false


func _on_DoorArea_body_exited(_body) -> void:
	RoomGlobals.loading = false


func _set_up_ability() -> void:
	randomize()
	var num := rand_range(1,4)
	num = int(round(num))
	if num == 1:
		$JumpBoost.queue_free()
		$MovementSpeed.queue_free()
		$Blink.queue_free()
		
	if num == 2:
		$Invisibility.queue_free()
		$MovementSpeed.queue_free()
		$Blink.queue_free()
		
	if num == 3:
		$Invisibility.queue_free()
		$JumpBoost.queue_free()
		$Blink.queue_free()
		
	if num == 4:
		$Invisibility.queue_free()
		$JumpBoost.queue_free()
		$MovementSpeed.queue_free()


func _set_up_Enemies() -> void:
	randomize()
	var num := rand_range(1,4)
	num = int(round(num))
	if num == 1:
		$Enemy3.queue_free()
		
	if num == 2:
		$Enemy2.queue_free()
		
	if num == 3:
		$Enemy.queue_free()
		


func _set_up_floppy() -> void:
	randomize()
	var num = rand_range(1,15)
	num = int(round(num))
	match num:
		1:
			$FloppyDisk3.queue_free()
			$FloppyDisk4.queue_free()
			$FloppyDisk5.queue_free()
			$FloppyDisk6.queue_free()
		2:
			$FloppyDisk2.queue_free()
			$FloppyDisk4.queue_free()
			$FloppyDisk5.queue_free()
			$FloppyDisk6.queue_free()
		3:
			$FloppyDisk3.queue_free()
			$FloppyDisk2.queue_free()
			$FloppyDisk5.queue_free()
			$FloppyDisk6.queue_free()
		4:
			$FloppyDisk3.queue_free()
			$FloppyDisk4.queue_free()
			$FloppyDisk2.queue_free()
			$FloppyDisk6.queue_free()
		5:
			$FloppyDisk3.queue_free()
			$FloppyDisk4.queue_free()
			$FloppyDisk5.queue_free()
			$FloppyDisk2.queue_free()
		6:
			$FloppyDisk.queue_free()
			$FloppyDisk4.queue_free()
			$FloppyDisk5.queue_free()
			$FloppyDisk6.queue_free()
		7:
			$FloppyDisk.queue_free()
			$FloppyDisk3.queue_free()
			$FloppyDisk5.queue_free()
			$FloppyDisk6.queue_free()
		8:
			$FloppyDisk.queue_free()
			$FloppyDisk4.queue_free()
			$FloppyDisk3.queue_free()
			$FloppyDisk6.queue_free()
		9:
			$FloppyDisk.queue_free()
			$FloppyDisk4.queue_free()
			$FloppyDisk5.queue_free()
			$FloppyDisk3.queue_free()
		10:
			$FloppyDisk.queue_free()
			$FloppyDisk2.queue_free()
			$FloppyDisk5.queue_free()
			$FloppyDisk6.queue_free()
		11:
			$FloppyDisk.queue_free()
			$FloppyDisk2.queue_free()
			$FloppyDisk4.queue_free()
			$FloppyDisk6.queue_free()
		12:
			$FloppyDisk.queue_free()
			$FloppyDisk2.queue_free()
			$FloppyDisk5.queue_free()
			$FloppyDisk4.queue_free()
		13:
			$FloppyDisk.queue_free()
			$FloppyDisk2.queue_free()
			$FloppyDisk3.queue_free()
			$FloppyDisk6.queue_free()
		14:
			$FloppyDisk.queue_free()
			$FloppyDisk2.queue_free()
			$FloppyDisk5.queue_free()
			$FloppyDisk3.queue_free()
		15:
			$FloppyDisk.queue_free()
			$FloppyDisk2.queue_free()
			$FloppyDisk3.queue_free()
			$FloppyDisk4.queue_free()
