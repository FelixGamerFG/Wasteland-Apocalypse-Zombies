extends Node

##variables de nodos
@onready var IP_edit = $Menues/Multijugador/CenterContainer/VBoxContainer/IP_Edit
@onready var multijugador_title: Label = $Menues/MultijugadorTitle
@onready var IP_ADRESS_LB: Label = $Menues/Multijugador/CenterContainer/VBoxContainer/IP
@onready var center_container: CenterContainer = $Menues/CenterContainer
@onready var camera = $SubViewport/Camera_pj1
@onready var sprite_2d: Sprite2D = $Menues/Backgroung/Sprite2D
@onready var mode_local: CanvasLayer = $UI_jugs_local
@onready var pj2 = $"../$SubViewport/Camera_pj1/2"



##variables normales
var peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()
var IP_ADRESS = "localhost"
var PORT = 7777

var tiempo = Timer.new()
var permiso_local = false


func _ready() -> void:
	add_child(tiempo)
	tiempo.start(60)
	if tiempo.timeout: print(str(int(tiempo.time_left)) + "s: " + "Account: " + Data_Pj.datosJP.Nombre)
	if tiempo.timeout: print(str(int(tiempo.time_left)) + "s: " + "Account2: " + Data_Pj.datosJP.Nombre2)

	



##evento constante
func _process(delta: float) -> void:
	
	
	##sistema de multijugador local (Censurado)
	#if pj2 != null:
		#camera.position.x = pj2.position.x
		#camera.position.y = pj2.position.y
	
	
	IP_ADRESS_LB.text = IP_ADRESS
	
	##sistema de multijugador local (Censurado)
	#if $Menues.activar_multiplayer && permiso_local:
		#_on_peer_connected_local()
		#$Menues.activar_multiplayer = false
	
	#Por ahora no funciona
	if IP_edit.text == "":
		IP_ADRESS = "192.168.43.1"
	else:
		IP_ADRESS = IP_edit.text
		
	if IP_edit.text == "1":
		IP_ADRESS = "localhost"
	
	
	
	
	


##crear partida
func _on_host_pressed() -> void:
	permiso_local = true
	peer.create_server(PORT,5)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	_on_peer_connected()
	if tiempo.timeout: print(str(int(tiempo.time_left)) + "s: Partida Creada")

	
##unirce a partida
func _on_join_pressed() -> void:
	permiso_local = false
	peer.create_client(IP_ADRESS,PORT)
	multiplayer.multiplayer_peer = peer
	if tiempo.timeout: print(str(int(tiempo.time_left)) + "s: Partida unida")


##Evento de reconocer cuando un player se conecta
func _on_peer_connected(id : int = 1):
	IP_ADRESS = IP_edit.text 
	var player_scene = load("res://scenes/characters/players/pj.tscn").instantiate()
	player_scene.name = str(id)
	add_child(player_scene, true)
	
	
	
	

##Evento de reconocer cuando un player se desconecta
func _on_peer_disconnected(id : int):
	for child in get_children():
		if child is player && child.name == str(id):
			child.queue_free()
			
			
##NO TOCAR ESTA FUNCION , NO ESTA TERMINADA, ESTA EN FASE DE PRUEBA
func _on_server_disconnected(id : int = 1):
	get_tree().reload_current_scene()
	multiplayer.multiplayer_peer = null
	

##sistema de multijugador local (Censurado)	
##Evento de reconocer cuando un player se conecta localmente(misma pantalla)
#func _on_peer_connected_local(id : int = 2):
	#mode_local.visible = true
	#var player_scene = load("res://scenes/characters/players/pj2.tscn").instantiate()
	#player_scene.name = str(id)
	#add_child(player_scene, true)
	
	
	
	
