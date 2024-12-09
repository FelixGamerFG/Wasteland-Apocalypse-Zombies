extends Node

@onready var IP_edit = $CanvasLayer/Control/CenterContainer/VBoxContainer/LineEdit
@onready var multijugador_title: Label = $CanvasLayer/Control/MultijugadorTitle
@onready var text_map: Label = $CanvasLayer/Control/textMap
@onready var center_container: CenterContainer = $CanvasLayer/Control/CenterContainer
@onready var create_edit: Button = $CanvasLayer/Control/CreateEdit
@onready var name_edit: LineEdit = $CanvasLayer/Control/NameEdit
@onready var menu: CanvasLayer = $CanvasLayer



var peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()

var IP_ADRESS = "localhost" #for gpa
var PORT = 7777




func _ready() -> void:
	
	#verificar cuenta existente
	if Data_Pj.datosJP.Nombre != "name_null":
		text_map.visible = true
		multijugador_title.visible = true
		center_container.visible = true
		name_edit.visible = false
		create_edit.visible = false
	else:
		center_container.visible = false
		name_edit.visible = true
		text_map.visible = false
		multijugador_title.visible = false

func _process(delta: float) -> void:
	text_map.text = IP_ADRESS
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
	text_map.visible = true
	IP_ADRESS = IP_edit.text 
	var player_scene = load("res://scenes/characters/players/pj.tscn").instantiate()
	player_scene.name = str(id)
	add_child(player_scene, true)
	print(str(id))


func _on_create_edit_pressed() -> void:
	text_map.visible = true
	center_container.visible = true
	name_edit.visible = false
	create_edit.visible = false
	Data_Pj.datosJP.Nombre = name_edit.text
	Data_Pj._save_data()
	
	pass
