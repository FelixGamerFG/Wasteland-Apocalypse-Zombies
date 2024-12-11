extends Node

##variables
#constrantes
const SaveFile = "res://Saves/SaveFile.text"


#normales
var datosJP = {
	"Nombre": "name_null",
	"Nombre2": "name_null"
}

var tiempo = Timer.new()


##nodo al empezar
func _ready() -> void:
	_load_data()
	add_child(tiempo)
	tiempo.start(60)
	if tiempo.timeout: print(str(int(tiempo.time_left)) + "s: leer datos de salvados")
	
	
##cargar partida
func _load_data():
	var file = FileAccess.open(SaveFile,FileAccess.READ)
	if file == null:
		_save_data()
	else:
		datosJP = file.get_var()
	file = null
	if tiempo.timeout: print(str(int(tiempo.time_left)) + "s: cargo")

##salvar partida
func _save_data():
	var file = FileAccess.open(SaveFile,FileAccess.WRITE)
	file.store_var(datosJP)
	file = null
	if tiempo.timeout: print(str(int(tiempo.time_left)) + "s: saver")
