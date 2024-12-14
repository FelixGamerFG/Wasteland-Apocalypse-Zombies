extends CharacterBody2D

##variables
#propiedades de jugador (exports)
@export var speed : float = 100
@export var jump : float = 400
@export var grav: float = 50

#propiedades
@export var joystick_left : VirtualJoystick
@onready var Anim = $Anim
@onready var Camara = $Camera_pj1
@onready var Skin2d : Sprite2D = $Sprite2D
@onready var alineacionChat: VBoxContainer = $UI/VBoxContainer
@onready var LB_name: Label = $Name

var tiempo = Timer.new()




func _ready() -> void:
	get_node("Camera_pj1").visible = false
	
	add_child(tiempo)
	tiempo.start(60)
	
	if tiempo.timeout: print(str(int(tiempo.time_left)) + "s: Jugado conectado")
	
	
	LB_name.text = str(Data_Pj.datosJP.Nombre2)


func _process(delta: float) -> void:
	
	
	## Script para darle autoridad a la camara de cada jugador
	Camara.enabled = false
	
	
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



func _physics_process(delta: float) -> void:
	
	## Movement using Input functions:
	
	
	if !is_on_floor():
		velocity.y += grav
		
	#salto
	if is_on_floor() && Input.is_action_just_pressed("ui_up"):
		velocity.y -= jump
	
	#movimientos horizontales
	velocity.x = Input.get_axis("izq","der") * speed
	move_and_slide()
