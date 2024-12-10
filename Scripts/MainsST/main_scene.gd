extends Node

##variables de nodos
@onready var IP_edit = $Control/CenterContainer/VBoxContainer/LineEdit
@onready var multijugador_title: Label = $Control/MultijugadorTitle
@onready var text_map: Label = $Control/CenterContainer/VBoxContainer/textMap
@onready var center_container: CenterContainer = $Control/CenterContainer

##variables normales
var peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()
var IP_ADRESS = "localhost"
var PORT = 7777

var tiempo = Timer.new()



func _ready() -> void:
	IP_edit.text = "1"
	add_child(tiempo)
	tiempo.start(60)
	if tiempo.timeout: print(str(int(tiempo.time_left)) + "s: " + "Account: " + Data_Pj.datosJP.Nombre)



##evento constante
func _process(delta: float) -> void:
	text_map.text = IP_ADRESS
	#if Input.is_action_just_pressed("ui_accept"):
		#get_tree().reload_current_scene()
	
	#Por ahora no funciona
	if IP_edit.text == "":
		IP_ADRESS = "192.168.43.1"
	else:
		IP_ADRESS = IP_edit.text
		
	if IP_edit.text == "1":
		IP_ADRESS = "localhost"
	
	
	
	
	


##crear partida
func _on_host_pressed() -> void:
	peer.create_server(PORT,5)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	_on_peer_connected()
	center_container.hide()
	if tiempo.timeout: print(str(int(tiempo.time_left)) + "s: Partida Creada")

	
##unirce a partida
func _on_join_pressed() -> void:
	peer.create_client(IP_ADRESS,PORT)
	multiplayer.multiplayer_peer = peer
	center_container.hide()
	if tiempo.timeout: print(str(int(tiempo.time_left)) + "s: Partida unida")


##Evento de reconocer cuando un player se conecta
func _on_peer_connected(id : int = 1):
	text_map.visible = true
	IP_ADRESS = IP_edit.text 
	var player_scene = load("res://scenes/characters/players/pj.tscn").instantiate()
	player_scene.name = str(id)
	add_child(player_scene, true)
