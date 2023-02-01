extends KinematicBody2D
class_name CharacterPlayer

const DIRECTION_RIGHT = 1
const DIRECTION_LEFT = -1

export (int) var speed = 200
export (int) var posYtarget = 50

var target = Vector2.ZERO
var velocity = Vector2.ZERO
var current_position = Vector2.ZERO
var temporary_position = Vector2.ZERO
var direction = Vector2(DIRECTION_RIGHT, 1)
var door_name = null
var isCaring = "no"
var MapCaring = ""

onready var Map = get_parent().name
onready var playerAlive = true
onready var isMove = false

func _ready():
	if Map == "Map1":
		MapCaring = "no"
	elif Map == "Map2":
		MapCaring = "yes"
	elif Map == "MapProlog":
		MapCaring = "yes"
		isCaring = "yes"
	else:
		pass
	target = Vector2(global_position.x,global_position.y+posYtarget)

func _physics_process(delta):
	delta = delta
	if playerAlive:
		_move_to_mouse()
	else :
		$Label.text = str("Mati")

func set_apply_scale(hor_dir_mod):
	$Idle.apply_scale(Vector2(hor_dir_mod * direction.x, 1))
	$Run.apply_scale(Vector2(hor_dir_mod * direction.x, 1))
	$CollisionShape2D.apply_scale(Vector2(hor_dir_mod * direction.x, 1))
	$Area2D.apply_scale(Vector2(hor_dir_mod * direction.x, 1))

func set_direction(hor_direction):
	if hor_direction == 0:
		hor_direction = DIRECTION_RIGHT # default to right if param is 0
	var hor_dir_mod = hor_direction / abs(hor_direction) # get unit direction
	set_apply_scale(hor_dir_mod)# flip
	direction = Vector2(hor_dir_mod, direction.y) # update direction

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("ui_left_click") and event.doubleclick:
			isMove = true
			target = Vector2(get_global_mouse_position().x,self.global_position.y)

func _faceTo():
	if target.x > global_position.x:
		set_direction(DIRECTION_RIGHT)
	else :
		set_direction(DIRECTION_LEFT)

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
	if isMove:
		_faceTo()
		$AnimChara.play("Run")
	else:
		$AnimChara.play("Idle")

func _pintu_area_entered(area):
	var nameMap = str(get_parent())
	var btnPopUpPintu = self.get_node("PopUp_Pintu/Button2")
	var labelPopUpPintu = self.get_node("PopUp_Pintu/Label")
	if area.is_in_group("Pintu"):
		$PopUp_Pintu.visible = true
		labelPopUpPintu.text = str("Masuk ke pintu lantai 2")
		btnPopUpPintu.visible = true
		setDoorName(area.name)
	elif area.is_in_group("Finish"):
		if get_parent().get_node("Finish"):
			print("isCaring = "+ MapCaring)
			if MapCaring == "no" :
				$PopUp_Pintu.visible = true
				labelPopUpPintu.text = str("Pindah Scene ?")
				btnPopUpPintu.visible = true
				setIsCaring("finish")
				setDoorName("PindahScene2")
			if MapCaring == "yes" :
				setIsCaring("yes")
				get_node("/root/"+Map+"/Finish").visible = false
	if area.is_in_group("PintuFinish"):
		if getIsCaring() == "yes":
			$PopUp_Pintu.visible = true
			labelPopUpPintu.text = str("Kunci didapat, Masuk !")
			btnPopUpPintu.visible = true
			setDoorName("PintuFinish")
		else:
			$PopUp_Pintu.visible = true
			labelPopUpPintu.text = str("Ambil Kunci dibawah")
			btnPopUpPintu.visible = false

func _pintu_area_exited(area):
	if area.is_in_group("Pintu"):
		$PopUp_Pintu.visible = false
	if area.is_in_group("Finish"):
		$PopUp_Pintu.visible = false
	if area.is_in_group("PintuFinish"):
		$PopUp_Pintu.visible = false

func setIsCaring(isCaring):
	self.isCaring = isCaring

func getIsCaring():
	return self.isCaring

func setDoorName(doorName):
	self.door_name = doorName

func getDoorName():
	return self.door_name

func setNewTargetPosition(pos: Vector2):
	target = Vector2(pos.x,pos.y+posYtarget)
