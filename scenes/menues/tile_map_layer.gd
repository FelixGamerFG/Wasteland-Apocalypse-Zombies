extends TileMapLayer

@export var noiseTexture: NoiseTexture2D
@onready var noise: FastNoiseLite = noiseTexture.noise

@export var chunk_size = 10
@export var chunk_cant = 5

var chunk_status: Dictionary = {}
var chunk_data: Dictionary = {}

func _ready() -> void:
	randomize()
	noise.seed = randi()
	generate_world(Vector2(0, 0))

func update_chunk(chunk_pos: Vector2) -> void:
	for x in range(-chunk_cant, chunk_cant):
		for y in range(-chunk_cant, chunk_cant):
			var current_pos = chunk_pos + Vector2(x, y)
			
			if chunk_status.get(current_pos, false) != true:
				cargar_chunk(current_pos)
				
	for current_pos in chunk_status.keys():
		if chunk_status[current_pos] == true and current_pos.distance_to(chunk_pos) > chunk_cant:
			descargar_chunk(current_pos)

func guardar_chunk(chunk_pos: Vector2) -> void:
	var start_x = chunk_pos.x * chunk_size
	var start_y = chunk_pos.y * chunk_size
	
	var tiles_chunk = []
	
	for x in range(start_x, start_x + chunk_size):
		for y in range(start_y, start_y + chunk_size):
			var cell = get_cell_atlas_coords(Vector2(x, y))
			if cell != null:
				tiles_chunk.append({"pos": Vector2(x, y), "tile": cell})
	chunk_data[chunk_pos] = tiles_chunk

func cargar_chunk(chunk_pos: Vector2) -> void:
	if chunk_status.get(chunk_pos, false) == true:
		return
	
	if chunk_pos in chunk_data:
		for tile in chunk_data[chunk_pos]:
			set_cell(tile["pos"], 0, tile["tile"])
	else:
		generate_world(chunk_pos)
	chunk_status[chunk_pos] = true

func descargar_chunk(chunk_pos: Vector2) -> void:
	if chunk_status.get(chunk_pos, false) == false:
		return
		
	var start_x = chunk_pos.x * chunk_size
	var start_y = chunk_pos.y * chunk_size
	
	for x in range(start_x, start_x + chunk_size):
		for y in range(start_y, start_y + chunk_size):
			erase_cell(Vector2i(x, y))
			
	chunk_status[chunk_pos] = false

func generate_world(chunk_pos: Vector2) -> void:
	var start_x = chunk_pos.x * chunk_size
	var start_y = chunk_pos.y * chunk_size
	
	for x in range(start_x, start_x + chunk_size):
		for y in range(start_y, start_y + chunk_size):
			var noise_value = noise.get_noise_2d(x, y)
			
			if y > noise_value * 15:  # Ajuste de la condición de generación
				set_cell(Vector2(x, y), 0, Vector2i(1, 1))
			elif y > noise_value * 16:
				set_cell(Vector2(x, y), 0, Vector2i(1, 0))
				
	chunk_status[chunk_pos] = true
	guardar_chunk(chunk_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
