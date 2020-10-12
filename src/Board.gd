extends TileMap

export var grid_size = Vector2(5, 5)
export var generation_counter = 0
var cell_matrix = []


func _ready():
	cell_matrix = generate_random_matrix(grid_size.y, grid_size.x, 0.3)
	update_visual_cell_matrix()
	generation_counter = 0


# Functionality for the next generation in the game - calls the next_generation
# and updates the tilemap
func update_next_generation():
	cell_matrix = next_generation(cell_matrix)
	update_visual_cell_matrix()
	generation_counter += 1
	$HUD.update_counter(generation_counter)


# Functionality for the randomize button - creates a new cell_matrix and updates
# the tilemp
func randomize_matrix():
	cell_matrix = generate_random_matrix(grid_size.y, grid_size.x, 0.3)
	update_visual_cell_matrix()	
	generation_counter = 0
	$HUD.update_counter(generation_counter)


# Clear the matrix with no live cells
func clear_matrix():
	cell_matrix = generate_random_matrix(grid_size.y, grid_size.x, 0)
	update_visual_cell_matrix()	
	generation_counter = 0
	$HUD.update_counter(generation_counter)


# Changes the camera zoom with the values of the slider (min and max values
# specified in the slider config)
func zoom_value_changed(value):
	$Camera2D.zoom.x = value
	$Camera2D.zoom.y = value
	
	
	
# Handles the creation or deletion of cells in the cell_matrix by clicking
# on the cells.
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			var cell_coords = world_to_map(event.position)
			
			# Don't do anything if clicked outside the grid
			if (cell_coords.y >= cell_matrix.size() or 
				cell_coords.x >= cell_matrix[cell_coords.y].size()):
				return
			
			var current_status = cell_matrix[cell_coords.y][cell_coords.x]
			cell_matrix[cell_coords.y][cell_coords.x] = not current_status
			
			update_visual_cell_matrix()


# Updates the game board to match `cell_matrix`, just a visual representation
# of the internal game board.
func update_visual_cell_matrix():
	for y in cell_matrix.size():
		for x in cell_matrix[y].size():
			if cell_matrix[y][x]:
				set_cell(x, y, 0)
			else:
				set_cell(x, y, -1)


# Generates a random cell matrix
func generate_random_matrix(columns, rows, alive_ratio):
	var new_cell_matrix = []
	randomize()
	
	for y in range(columns):
		new_cell_matrix.append([]) 
		for x in range(rows):
			var cell_value = randf() < alive_ratio
			new_cell_matrix[y].append(cell_value)

	return new_cell_matrix


# Actual game of life code:
func next_generation(cell_matrix):
	if cell_matrix.size() == 0:
		return []
	
	# Generates the matrix that will be returned with all the cells as false
	var new_gen_cell_matrix = generate_random_matrix(cell_matrix.size(), 
												   cell_matrix[0].size(), 0)
	
	for y in cell_matrix.size():
		for x in cell_matrix[y].size():
			var live_neighbours = get_number_of_live_neighbours(cell_matrix, y, x)
			
			var cell_state = cell_matrix[y][x]
				
			if cell_state and live_neighbours in [2, 3]:
				new_gen_cell_matrix[y][x] = true  # not needed technically as it's already alive
			elif not cell_state and live_neighbours == 3:
				new_gen_cell_matrix[y][x] = true
			else:
				new_gen_cell_matrix[y][x] = false
	
	return new_gen_cell_matrix
	
	
# Returns the number of live neighbours for a cell in a specific coordinate
func get_number_of_live_neighbours(cell_matrix, y, x):
	var neighbours_coords = [
		[y - 1, x - 1],
		[y - 1, x],
		[y - 1, x + 1],
		[y, x - 1],
		[y, x + 1],
		[y + 1, x - 1],
		[y + 1, x],
		[y + 1, x + 1]
	]
	
	var number_of_live_neighbours = 0
	
	for coords in neighbours_coords:
		var aux_y = coords[0]
		var aux_x = coords[1]
		
		# Skip  any neighbour coords that are out of bounds of the array
		if (aux_y >= cell_matrix.size() or aux_x >= cell_matrix[0].size() 
			or aux_y < 0 or aux_x < 0):
			continue
		
		if cell_matrix[aux_y][aux_x]:
			number_of_live_neighbours += 1
	
	return number_of_live_neighbours
	
	


