extends KinematicBody2D
class_name CharacterPlayer

export (int) var speed = 200

var target = Vector2.ZERO
var velocity = Vector2.ZERO
var door_name = null


onready var playerAlive = true
onready var isMove = false

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_left_click") and event.doubleclick:
			isMove = true
			target = Vector2(get_global_mouse_position().x,self.global_position.y)

func _physics_process(delta):
	delta = delta
	if playerAlive:
		_move_to_mouse()
	else :
		$Label.text = str("Mati")
	
func _move_to_mouse():
	if target:
		velocity = global_position.direction_to(target) * speed
		if global_position.length() < 3:
			isMove = false
			return

	if !global_position.distance_to(target) > 5:
		isMove = false
	else:
		velocity = move_and_slide(velocity)

func _pintu_area_entered(area):
	if area.is_in_group("Pintu"):
		$PopUp_Pintu.visible = true
		setDoorName(area.name)
	if area.is_in_group("Finish"):
		$Label.text = str("Finish")

func _pintu_area_exited(area):
	if area.is_in_group("Pintu"):
		$PopUp_Pintu.visible = false

func setDoorName(doorName):
	self.door_name = doorName

func getDoorName():
	return door_name

func setNewTargetPosition(pos: Vector2):
	target = Vector2(pos.x,pos.y)
