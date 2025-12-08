extends TileMapLayer

signal tile_clicked_left(coords: Vector2i, power: int)
signal tile_clicked_right(coords: Vector2i, power: int)

var tile_states: Array = []

var mapSize = Vector2i(5,5)

func _ready():
	init_tile_states()
	# Make sure this node processes input events
	set_process_input(true)

func init_tile_states() -> void:	
	# Initialize tile states to null
	tile_states = []
	for y in range(mapSize.y):
		var row = []
		for x in range(mapSize.x):
			row.append(null)
			set_cell(Vector2i(x,y),0,Vector2i(0,0))
		tile_states.append(row)
	print("TileMapLayer is ready.")
	pass

# Return the tile states for external access
func get_tile_states() -> Array:
	return tile_states



func set_mapSize(size: Vector2i) -> void:
	mapSize = size
	init_tile_states()
	pass

# Use _unhandled_input for input events
func _unhandled_input(event):
	# Debugging to check if the event is received
	if event is InputEventMouseButton and event.pressed:
		# Get the global mouse position
		var global_mouse_pos = get_global_mouse_position()
		
		# Convert the global mouse position to the local coordinate system of the TileMapLayer
		var local_mouse_pos = to_local(global_mouse_pos)
		
		# Get the tile coordinates in the grid
		var clicked_coords = local_to_map(local_mouse_pos)

		print("Global mouse position:", global_mouse_pos)
		print("Local mouse position:", local_mouse_pos)
		print("Tile coordinates:", clicked_coords)

		# Emit the signal when a tile is clicked
		if clicked_coords.x < mapSize.x and clicked_coords.y < mapSize.y and clicked_coords.x >= 0 and clicked_coords.y >= 0:
			if event.button_index == MOUSE_BUTTON_LEFT:
				emit_signal("tile_clicked_left", clicked_coords, 1)  # Example power value: 1
			else: if event.button_index == MOUSE_BUTTON_RIGHT:
				emit_signal("tile_clicked_right", clicked_coords, 1) 


func _on_tile_clicked_left(coords: Vector2i, power: int) -> void:
	if $"..".isCoordEmpty(coords):
		set_cell(coords,0,Vector2i(1,1))
		return
	if get_cell_atlas_coords(coords).x == 0:
		set_cell(coords,0,Vector2i(1,0))
	else:		
		set_cell(coords,0,Vector2i(0,0))
	pass # Replace with function body.

func _on_tile_clicked_right(coords: Vector2i, power: int) -> void:
	if get_cell_atlas_coords(coords).x == 0 and get_cell_atlas_coords(coords).y == 0:
		set_cell(coords,0,Vector2i(0,1))
	else: if get_cell_atlas_coords(coords).x == 0 and get_cell_atlas_coords(coords).y == 1:		
		set_cell(coords,0,Vector2i(0,0))
	pass # Replace with function body.

func switch_tile_texture() -> void:
	pass
	
