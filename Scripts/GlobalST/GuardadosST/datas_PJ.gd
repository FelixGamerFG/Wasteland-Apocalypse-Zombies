extends Node

##variables
#constrantes
const SaveFile = "user://SaveFile_jp.save"

#normales
var datosJP = {
	"Nombre": "name_null"
}

##evento al empezar
func _ready() -> void:
	_load_data()
	print("leer datos de salvados")
	
	
##cargar partida
func _load_data():
	var file = FileAccess.open(SaveFile,FileAccess.READ)
	if file == null:
		_save_data()
	else:
		datosJP = file.get_var()
	file = null
	print("cargo")

##salvar partida
func _save_data():
	var file = FileAccess.open(SaveFile,FileAccess.WRITE)
	file.store_var(datosJP)
	file = null
	print("saver")
