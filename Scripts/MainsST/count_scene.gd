extends Node

@onready var name_edit: LineEdit = $Control/NameEdit
	
	
	
	
	
func _ready() -> void:
	#verificar cuenta existente
	if Data_Pj.datosJP.Nombre != "name_null":
		get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
		
		
		

func _on_create_edit_pressed() -> void:
	Data_Pj.datosJP.Nombre = name_edit.text
	Data_Pj._save_data()
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
	
	pass
