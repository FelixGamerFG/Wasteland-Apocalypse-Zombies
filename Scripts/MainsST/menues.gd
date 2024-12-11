extends Control

@onready var menu_principal: Control = $Menu_Principal
@onready var multijugador: Control = $Multijugador

var activar_multiplayer = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		activar_multiplayer = true
		

func _on_multijugador_pressed() -> void:
	menu_principal.hide()
	multijugador.show()


func _on_back_pressed() -> void:
	menu_principal.show()
	multijugador.hide()


func _on_salir_pressed() -> void:
	get_tree().quit()
