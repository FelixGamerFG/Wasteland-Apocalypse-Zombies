extends CharacterBody2D

@export var speed : float = 100
@export var grav: float = 50

@export var joystick_left : VirtualJoystick
@onready var Anim = $Anim
@onready var Camara = $Camara

@onready var Skin2d : Sprite2D = $Sprite2D

var move_vector = Vector2.ZERO


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _process(delta: float) -> void:
	
	print(position.y) #eliminar si no es necesacio


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
	"""if is_on_floor():
		velocity.y = -grav"""
	
	#movimientos horizontales
	velocity.x = Input.get_axis("ui_left","ui_right") * speed
	move_and_slide()
	
	
