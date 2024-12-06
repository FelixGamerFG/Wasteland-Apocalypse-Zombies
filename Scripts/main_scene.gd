extends Node

@onready var menu = $CenterContainer
var peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()

var port = "192.168.0.0" #for gpa





func _on_host_pressed() -> void:
	peer.create_server(3500,5)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	_on_peer_connected()
	menu.hide()

func _on_join_pressed() -> void:
	peer.create_client("localhost", 3500)
	multiplayer.multiplayer_peer = peer
	menu.hide()


func _on_peer_connected(id : int = 1):
	var player_scene = load("res://pj.tscn")
	var player_instance = player_scene.instantiate()
	player_instance.name = str(id)
	add_child(player_instance, true)
