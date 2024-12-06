extends CharacterBody2D

@export var speed : float = 100

@export var joystick_left : VirtualJoystick
@onready var Anim = $Anim

var move_vector = Vector2.ZERO

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	
	if velocity.x > 0 && velocity.y == 0:
		Anim.play("CAMIMAR")
		
	if velocity.x < 0 && velocity.y == 0:
		Anim.play("CAMINAR")
		
	if velocity.x == 0:
		Anim.play("QUIETO")
		
	if velocity.y > 0:
		Anim.play("QUIETO")
		
	if velocity.y < 0:
		Anim.play("QUIETO")

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	## Movement using Input functions:
	velocity = Input.get_vector("ui_left","ui_right", "ui_up", "ui_down") * speed
	move_and_slide()
	
	
