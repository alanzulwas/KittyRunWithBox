extends KinematicBody2D

var target = Vector2.ZERO
var velocity = Vector2.ZERO
export var is_moving_right = true
var targettinCharacter = false
export (int) var speed = 200

onready var Map = get_node("../").name
onready var Chara = get_node("/root/"+Map+"/Sprite")

func _ready():
	if !is_moving_right :
		scale.x = -scale.x

func _physics_process(delta):
	delta = delta
	if targettinCharacter and Chara.isMove:
		Chara.playerAlive = false
		_move_to_object()
	else : 
		_enemyMove()
		_detectTurnAround()

func _on_DetectPlayer_body_entered(body):
	if body.is_in_group("Player"):
		targettinCharacter = true
		target = body.global_position

func _on_DetectPlayer_body_exited(body):
	if body.is_in_group("Player"):
		targettinCharacter = false

func _move_to_object():
	if global_position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)

	if target:
		velocity = global_position.direction_to(target) * speed
		if global_position.length() < 3:
			return

func _enemyMove():
	var sspeed = speed / 2.5
	velocity.x = sspeed if is_moving_right else -sspeed
	velocity = move_and_slide(velocity)

func _detectTurnAround():
	if $RayCast2D.is_colliding():
		print("osdojkdsaj")
		is_moving_right = !is_moving_right
		scale.x = -scale.x
