extends KinematicBody2D

var target = Vector2.ZERO
var velocity = Vector2.ZERO
export (int) var speed = 200

func _physics_process(delta):
	_move_to_object()

func _on_DetectPlayer_body_entered(body):
	if body.is_in_group("Player"):
		print("body masuk : ",body.global_position)
		target = body.global_position

func _move_to_object():
	if global_position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)

	if target:
		velocity = global_position.direction_to(target) * speed
		if global_position.length() < 3:
			return
