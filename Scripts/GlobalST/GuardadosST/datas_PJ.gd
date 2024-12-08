extends Node

const SaveFile  = "user://SaveFile_jp.save"

var datosJP = {
	"Nombre": "GPA mamaguevo"
}

func _ready() -> void:
	_load_data()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		_save_data()
		print("ok")
	
	
	
func _load_data():
	var file = FileAccess.open(SaveFile,FileAccess.READ)
	if file == null:
		_save_data()
	else:
		datosJP = file.get_var()
	file = null
	
func _save_data():
	var file = FileAccess.open(SaveFile,FileAccess.WRITE)
	file.store_var(datosJP)
	file = null
