extends Node

const SaveFile  = "user://SaveFile_jp.save"

var datosJP = {
	"Nombre": "name_null"
}

func _ready() -> void:
	_load_data()
	
	
	
func _load_data():
	var file = FileAccess.open(SaveFile,FileAccess.READ)
	if file == null:
		_save_data()
	else:
		datosJP = file.get_var()
	file = null
	print("cargo")
	
func _save_data():
	var file = FileAccess.open(SaveFile,FileAccess.WRITE)
	file.store_var(datosJP)
	file = null
	print("saver")
