class_name player
extends CharacterBody2D

@export var speed : float = 100
@export var jump : float = 400
@export var grav: float = 50


@export var joystick_left : VirtualJoystick
@onready var Anim = $Anim
@onready var Camara = $Camara
@onready var Skin2d : Sprite2D = $Sprite2D
@onready var LB_name: Label = $Name






func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())
	
	
	


func _ready() -> void:
	if !is_multiplayer_authority(): return
	LB_name.text = str(Data_Pj.datosJP.Nombre)



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

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	## Movement using Input functions:
	
	
	if !is_on_floor():
		velocity.y += grav
		
	#salto
	if is_on_floor() && Input.is_action_just_pressed("ui_up"):
		velocity.y -= jump
	
	#movimientos horizontales
	velocity.x = Input.get_axis("ui_left","ui_right") * speed
	move_and_slide()
