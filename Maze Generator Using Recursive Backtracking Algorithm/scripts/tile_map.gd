extends TileMap

signal setCamera

@onready var spin_box: SpinBox = $ButtonLayout/Control/VBoxContainer/SpinBox
@onready var spin_box_2: SpinBox = $ButtonLayout/Control/VBoxContainer/SpinBox2

func _ready() -> void:
	build_world(4, 4)#default dimension

func get_values():
	var height: int = spin_box.value
	var width: int = spin_box_2.value
	return {"h":height, "w":width}

func _on_button_pressed() -> void:
	clear() #clear Tilemap
	var dimensions = get_values()#get dimension of maze
	await build_world(dimensions.h, dimensions.w)#build maze for the given dimension
	setCamera.emit()
	
func build_world(height, width):
	var tilesArray: Array= MazeGen.mapTiles(height, width)

	var vector2: Array = []#stores tile data
	var vector2i: Array = []#placed in the autotiler
	
	for i in range(len(tilesArray)):
		for j in range(len(tilesArray[0])):	
			if tilesArray[i][j] == 1 :
				vector2.append(Vector2i(i, j))
			elif tilesArray[i][j] == 2 || tilesArray[i][j] == -2 :
				vector2.append(Vector2i(i, j))
				vector2i.append(Vector2i(i, j))			
			else:
				pass
	set_cells_terrain_connect(0, vector2, 0, 0, true)#auto tile
	
	for goal in vector2i:
		set_cell(0, goal, 0, Vector2i(3, 22), 0)#place goals(start, end)
	
