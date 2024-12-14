class_name player
extends CharacterBody2D

##variables
#propiedades de jugador (exports)
@export var speed : float = 100
@export var jump : float = 400
@export var grav: float = 50


#propiedades
@export var joystick_left : VirtualJoystick
@onready var Anim = $Anim
@onready var Camara = $Camara
@onready var Skin2d : Sprite2D = $Sprite2D
@onready var alineacionChat: VBoxContainer = $UI/VBoxContainer
@onready var LB_name: Label = $Name

## Timers
@onready var TimerChat: Timer= $Timers/TimerChat

##Chat
@onready var SalidaChat: Label = $Chat
@onready var Chat_Entrada: LineEdit = $UI/Chat/EntradaDeChat

@onready var world = $"../Mapa/TileMapLayer"
@onready var chunk_pos = Vector2(position.x / (world.chunk_size * 36) , position.y / (world.chunk_size * 36))
@onready var prevchunkpos = chunk_pos

var tiempo = Timer.new()




func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())
	
	
	


func _ready() -> void:
	get_node("Camara").visible = false
	add_child(tiempo)
	tiempo.start(60)
	if !is_multiplayer_authority():
		Chat_Entrada.hide()
		joystick_left.hide()
		if tiempo.timeout: print(str(int(tiempo.time_left)) + "s: Jugado conectado")
	
	if !is_multiplayer_authority(): return
	LB_name.text = str(Data_Pj.datosJP.Nombre)
	



func _physics_process(delta: float) -> void:
	
	if !is_multiplayer_authority(): return
	## Movement using Input functions:
	
	chunk_pos = Vector2(floor(position.x / (world.chunk_size * 36)) , floor(position.y / (world.chunk_size * 36)))
	
	if prevchunkpos != chunk_pos:
		world.update_chunk(chunk_pos)
		prevchunkpos = chunk_pos

	
	if !is_on_floor():
		velocity.y += grav
		
	#salto
	if is_on_floor() && Input.is_action_just_pressed("ui_up"):
		velocity.y -= jump
	
	#movimientos horizontales
	velocity.x = Input.get_axis("ui_left","ui_right") * speed
	move_and_slide()




func _process(delta: float) -> void:
		
	
	if !is_multiplayer_authority(): return
	## Script para darle autoridad a la camara de cada jugador
	Camara.enabled = true
		
	if velocity.x > 0 && velocity.y == 0:
		Anim.play("CAMIMAR")
		Skin2d.flip_h = false
		
	if velocity.x < 0 && velocity.y == 0:
		Anim.play("CAMINAR")
		Skin2d.flip_h = true
		
	if velocity.x == 0:
		Anim.play("QUIETO")
		
	if velocity.y > 0:
		Anim.play("QUIETO")
		
	if velocity.y < 0:
		Anim.play("QUIETO")


func _on_entrada_de_chat_text_submitted(new_text: String) -> void:
	rpc("_set_chat_salida", new_text)
	Chat_Entrada.release_focus()
	Chat_Entrada.text = ""
	TimerChat.start(3)
	
@rpc("authority","call_local")
func _set_chat_salida(text: String):
	SalidaChat.text = text

func _on_timer_chat_timeout() -> void:
	rpc("_set_chat_salida", "")
