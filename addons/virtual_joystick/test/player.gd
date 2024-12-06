extends CharacterBody2D

@export var speed : float = 100

@export var joystick_left : VirtualJoystick
@export var Anim = $Anim

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
	move_vector = Vector2.ZERO
	move_vector = Input.get_axis("ui_left","ui_right")
	velocity.x += move_vector * speed * delta
	
