extends TileMapLayer

func create_grid_for_room(room: RoomRect) -> AStarGrid2D:
	var grid = AStarGrid2D.new()
	var pixel_bounds = room.global_bounds()
	grid.region = Rect2(local_to_map(to_local(pixel_bounds.position)), local_to_map(to_local(pixel_bounds.size)))
	grid.cell_size = tile_set.tile_size
	grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	grid.update()
	
	grid.fill_solid_region(grid.region, true)
	for y in grid.region.size.y:
		for x in grid.region.size.x:
			var id = Vector2i(x, y)
			if get_cell_source_id(grid.region.position + id) != -1:
				grid.set_point_solid(Vector2i(x, y) + grid.region.position, false)
	
	return grid
