extends ColorRect

onready var Map = get_node("../..").name
onready var Chara = get_node("/root/"+ Map +"/Sprite")
onready var Pintu1_1 = get_node("/root/"+ Map+ "/Pintu1_1")
onready var Pintu1_2 = get_node("/root/"+ Map+ "/Pintu1_2")

func _ready():
	pass # Replace with function body.
	
func _on_Button2_pressed():
	Chara.get_node("PopUp_Pintu").visible = false
	if Chara.getDoorName() == "Pintu1_1":
		Chara.global_position = Pintu1_2.global_position
		Chara.setNewTargetPosition(Pintu1_2.global_position)
	if Chara.getDoorName() == "Pintu1_2":
		Chara.global_position = Pintu1_1.global_position
		Chara.setNewTargetPosition(Pintu1_1.global_position)
