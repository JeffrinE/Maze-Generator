extends Node2D

@onready var tilemap: TileMap = $TileMap
@onready var camera_2d: Camera2D = $TileMap/Camera2D


func calculate_center(worldSizeInPixels):
	#calculate center of the world to place camera
	worldSizeInPixels.x = worldSizeInPixels.x
	worldSizeInPixels.y = worldSizeInPixels.y + 16
	var center = Vector2(worldSizeInPixels.x/2 , worldSizeInPixels.y/2)
	return center

func set_camera() -> void:
	#place camera at the center of the world
	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.cell_quadrant_size
	var worldSizeInPixels = mapRect.size * tileSize
	camera_2d.global_position = calculate_center(worldSizeInPixels)

func _on_tile_map_set_camera() -> void:
	set_camera()
