class_name MazeGen
extends Node

class Maze:
	var width: int
	var height: int
	var maze: Array

	func _init(w: int, h: int) ->  void:
		width = w
		height = h
		maze = []
		for i in range(height):
			maze.append([])
			for j in range(width):
				maze[i].append(0) # Initialize with walls

	func generate_maze() -> void:
		# Start the maze generation from a random cell
		var start_x = randi() % (int(width / 2) - 1) * 2 + 1
		var start_y = randi() % (int(height / 2) - 1) * 2 + 1
		_carve_passages(start_x, start_y)

		# Create entry and exit points
		maze[start_y][0] = -2 # Entry point on the left side
		maze[start_y][width - 1] = 2 # Exit point on the right side

	func _carve_passages(x: int, y: int) -> void:
		# Directions: (dx, dy)
		var directions = [Vector2(-2, 0), Vector2(0, -2), Vector2(2, 0), Vector2(0, 2)]
		directions.shuffle() # Randomize the order of directions

		for direction in directions:
			var dx = direction[0]
			var dy = direction[1]
			var nx = x + dx
			var ny = y + dy
			
			if nx > 0 and nx < width and ny > 0 and ny < height and maze[ny][nx] == 0:
				# Carve a passage between the current cell and the new cell
				maze[y + dy / 2][x + dx / 2] = 1
				maze[ny][nx] = 1
				# Recursively carve passages from the new cell
				_carve_passages(nx, ny)

	func get_maze() -> Array:
		return maze


static func mapTiles(height: int, width: int) -> Array:
	randomize() # Seed the random number generator
	if (height % 2) == 0:#Convert to odd number if even
		height += 1
	if (width % 2) == 0:#Convert to odd number if even
		width += 1
	var maze_width = width # Must be an odd number
	var maze_height = height# Must be an odd number
	var maze_generator = Maze.new(maze_width, maze_height)
	maze_generator.generate_maze()
	# Print the maze as a nested list
	return maze_generator.get_maze()

