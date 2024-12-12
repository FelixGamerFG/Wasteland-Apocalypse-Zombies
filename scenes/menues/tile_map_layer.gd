extends TileMapLayer

@export var noiseTexture : NoiseTexture2D
@onready var noise : FastNoiseLite = noiseTexture.noise

var chunk_size = 20
var chunk_cant = 3

func _ready() -> void:
	generate_world(Vector2(0,0))

func generate_world(chunk_pos: Vector2) -> void:
	var start_x = chunk_pos.x * chunk_size
	var start_y = chunk_pos.y * chunk_size
	
	for x in range(start_x,start_x + chunk_size):
		for y in range(start_y,start_y + chunk_size):
			var noiseValue = noise.get_noise_2d(x,y)
			
			if noiseValue >= 0.2:
				set_cell(Vector2(x,y),0,Vector2i(9,0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
