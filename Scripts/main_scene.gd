extends Node
@onready var menu = $CenterContainer
var peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_host_pressed() -> void:
	peer.create_server(7777,5)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	_on_peer_connected()
	menu.hide()

func _on_join_pressed() -> void:
	peer.create_client("192.168.43.1", 7777)
	multiplayer.multiplayer_peer = peer
	menu.hide()


func _on_peer_connected(id : int = 1):
	var player_scene = load("res://pj.tscn")
	var player_instance = player_scene.instantiate()
	player_instance.name = str(id)
	add_child(player_instance, true)
