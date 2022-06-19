extends ColorRect

onready var Map = get_node("../..").name
onready var Chara = get_node("/root/"+ Map +"/Sprite")
onready var Pintu1_1 = get_node("/root/"+ Map+ "/Pintu1_1")
onready var Pintu1_2 = get_node("/root/"+ Map+ "/Pintu1_2")
onready var Pintu2_1 = get_node("/root/"+ Map+ "/Pintu2_1")
onready var Pintu2_2 = get_node("/root/"+ Map+ "/Pintu2_2")
#onready var Pintu3_1 = get_node("/root/"+ Map+ "/Pintu3_1")
#onready var Pintu3_2 = get_node("/root/"+ Map+ "/Pintu3_2") 

onready var p11_anim = get_node("/root/"+ Map+ "/Pintu1_1/AnimatedSprite")
onready var p12_anim = get_node("/root/"+ Map+ "/Pintu1_2/AnimatedSprite")
onready var p21_anim = get_node("/root/"+ Map+ "/Pintu2_1/AnimatedSprite")
onready var p22_anim = get_node("/root/"+ Map+ "/Pintu2_2/AnimatedSprite")
#onready var p31_anim = get_node("/root/"+ Map+ "/Pintu3_1/AnimatedSprite")
#onready var p32_anim = get_node("/root/"+ Map+ "/Pintu3_2/AnimatedSprite")
 
func _on_Button2_pressed():
	Chara.get_node("PopUp_Pintu").visible = false                                       
	if Chara.getDoorName() == "Pintu1_1":
		p11_anim.play("openDoor")
		p12_anim.play("openDoor")
		Chara.global_position = Pintu1_2.global_position
		Chara.setNewTargetPosition(Pintu1_2.global_position)
	if Chara.getDoorName() == "Pintu1_2":
		p11_anim.play("openDoor")
		p12_anim.play("openDoor")
		Chara.global_position = Pintu1_1.global_position
		Chara.setNewTargetPosition(Pintu1_1.global_position)
	if Chara.getDoorName() == "Pintu2_1":
		p21_anim.play("openDoor")
		p22_anim.play("openDoor")
		Chara.global_position = Pintu2_2.global_position
		Chara.setNewTargetPosition(Pintu2_2.global_position)
	if Chara.getDoorName() == "Pintu2_2":
		p21_anim.play("openDoor")
		p22_anim.play("openDoor")
		Chara.global_position = Pintu2_1.global_position
		Chara.setNewTargetPosition(Pintu2_1.global_position)
#	if Chara.getDoorName() == "Pintu3_1":
#		Chara.global_position = Pintu3_2.global_position
#		Chara.setNewTargetPosition(Pintu3_2.global_position)
#	if Chara.getDoorName() == "Pintu3_2":
#		Chara.global_position = Pintu3_1.global_position
#		Chara.setNewTargetPosition(Pintu3_1.global_position)
