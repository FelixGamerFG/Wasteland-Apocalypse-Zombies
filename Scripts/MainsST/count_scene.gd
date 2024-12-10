extends Node

##varianles de nodos
@onready var name_edit: LineEdit = $Control/UI/NameEdit
@onready var Fondo: ColorRect = $Control/UI/ColorRect
@onready var Error: Label = $Control/UI/Error

	


##nodo al empezar
func _ready() -> void:
	Error.visible = false
	
	#verificar cuenta existente
	if Data_Pj.datosJP.Nombre != "name_null":
		get_tree().change_scene_to_file("res://scenes/menues/main_scene.tscn")
		print("Cuenta iniciada")

func _process(delta: float) -> void:
	if name_edit.text != "":
		Error.visible = false
		
		
##evento al crear personaje
func _on_create_edit_pressed() -> void:
	Data_Pj.datosJP.Nombre = name_edit.text
	Data_Pj._save_data()
	if name_edit.text != "":
		get_tree().change_scene_to_file("res://scenes/menues/main_scene.tscn")
	else:
		Error.visible = true
	
	print("Cuenta iniciada")	

	
	pass
