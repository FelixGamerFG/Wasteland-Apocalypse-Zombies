extends Node

##varianles de nodos
@onready var name_edit: LineEdit = $UI/Nombre_PJ_1
@onready var name_edit2: LineEdit = $UI/Nombre_PJ_2
@onready var Fondo: ColorRect = $UI/ColorRect
@onready var Error: Label = $UI/Error
@onready var Error2: Label = $UI/Error2


var tiempo = Timer.new()


##nodo al empezar
func _ready() -> void:
	Error.visible = false
	Error2.visible = false
	add_child(tiempo)
	tiempo.start(60)
	
	#verificar cuenta existente
	if Data_Pj.datosJP.Nombre != "name_null" and Data_Pj.datosJP.Nombre2 != "name_null":
		get_tree().change_scene_to_file("res://scenes/menues/main_scene.tscn")
		if tiempo.timeout: print(str(int(tiempo.time_left)) + "s: Cuenta iniciada")

func _process(delta: float) -> void:
	if name_edit.text != "" and name_edit2.text != "":
		Error.visible = false
		Error2.visible = false
		
		
##evento al crear personaje
func _on_create_edit_pressed() -> void:
	Data_Pj.datosJP.Nombre = name_edit.text
	Data_Pj.datosJP.Nombre2 = name_edit2.text
	Data_Pj._save_data()
	if name_edit.text != "" and name_edit2.text != "":
		get_tree().change_scene_to_file("res://scenes/menues/main_scene.tscn")
	else:
		Error.visible = true
		Error2.visible = true
	
	if tiempo.timeout: print(str(int(tiempo.time_left)) + "s: Cuenta iniciada")	

	
	pass
