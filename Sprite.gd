#extends KinematicBody2D
#class_name CharacterPlayer
#
#export var move_speed = 250
#
#func _process(delta):
#	delta=delta
#	_look_at_mouse()
#	_move_to_mouse()
#
#func _look_at_mouse():
#	look_at(get_global_mouse_position())
#	rotation_degrees = rotation_degrees + 90
#
#func _move_to_mouse():
#	var direction = get_global_mouse_position() - position
#	var normalized_direction = direction.normalized()
#	move_and_slide(normalized_direction * move_speed)

#extends KinematicBody2D
#class_name CharacterPlayer
#
#var velocity = Vector2.ZERO
#var move_speed = 250
#var last_mouse_pos = null
#
#func _physics_process(delta):
#	delta = delta
##	_look_at_mouse()
#	_move_to_mouse()
#
##func _look_at_mouse():
##	look_at(get_global_mouse_position())
##	rotation_degrees = rotation_degrees + 90
#
#func _unhandled_input(event: InputEvent) -> void :
#	if event is InputEventMouseButton:
#		if event.is_action_pressed("ui_left_click") and event.doubleclick:
#			last_mouse_pos = get_global_mouse_position()
#
#func _move_to_mouse():
#
#	if last_mouse_pos:
#		var direction_vector = (last_mouse_pos - global_position)
#
#		if direction_vector.length() < 3:
#			return
#
#		direction_vector.y = -10
#
#		move_and_slide(direction_vector.normalized() * move_speed)

extends KinematicBody2D
class_name CharacterPlayer

export (int) var speed = 200

var target = Vector2.ZERO
var velocity = Vector2.ZERO

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_left_click") and event.doubleclick:
			target = Vector2(get_global_mouse_position().x,self.global_position.y)

func _ready():
	$PopUp_Pintu.visible = false

func _physics_process(delta):
	delta = delta
	_gravity()
	_move_to_mouse()
	
func _gravity() -> void :
	velocity.y += 25

	
func _move_to_mouse():
	
	if global_position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)
	
	if target:
		velocity = global_position.direction_to(target) * speed
		if global_position.length() < 3:
			return

func _pintu_area_entered(area):
	if area.is_in_group("Pintu"):
		$PopUp_Pintu.visible = true
		print("Masuk pintu")


func _pintu_area_exited(area):
	if area.is_in_group("Pintu"):
		$PopUp_Pintu.visible = false
