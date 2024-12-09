extends Node

@onready var menu = $Control/CenterContainer
@onready var IP_edit = $Control/CenterContainer/VBoxContainer/LineEdit

var peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()

var IP_ADRESS = "localhost" #for gpa
var PORT = 0000

func _ready() -> void:
	
	#verificar cuenta existente
	if Data_Pj.datosJP.Nombre != "name_null":
		$CanvasLayer/textMap.visible = true
		$Control/CenterContainer.visible = true
		$Control/NameEdit.visible = false
		$Control/CreateEdit.visible = false
	else:
		$Control/CenterContainer.visible = false
		$Control/NameEdit.visible = true
		$CanvasLayer/textMap.visible = false

func _process(delta: float) -> void:
	$CanvasLayer/textMap.text = IP_ADRESS
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()
		
	
	#sistema de iniciar cuenta
	
	
	
	
	
##Por ahora no funciona
	if IP_edit.text == "":
		IP_ADRESS = "192.168.43.1"
	else:
		IP_ADRESS = IP_edit.text
		
	if IP_edit.text == "1":
		IP_ADRESS = "localhost"
		
func _on_host_pressed() -> void:
	peer.create_server(PORT,5)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	_on_peer_connected()
	menu.hide()
	

func _on_join_pressed() -> void:
	peer.create_client(IP_ADRESS,PORT)
	multiplayer.multiplayer_peer = peer
	menu.hide()


func _on_peer_connected(id : int = 1):
	$CanvasLayer/textMap.visible = true
	IP_ADRESS = IP_edit.text 
	var player_scene = load("res://scenes/characters/players/pj.tscn").instantiate()
	player_scene.name = str(id)
	add_child(player_scene, true)
	print(str(id))


func _on_create_edit_pressed() -> void:
	$CanvasLayer/textMap.visible = true
	$Control/CenterContainer.visible = true
	$Control/NameEdit.visible = false
	$Control/CreateEdit.visible = false
	Data_Pj.datosJP.Nombre = $Control/NameEdit.text
	Data_Pj._save_data()
	
	pass
