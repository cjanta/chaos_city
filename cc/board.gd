extends Node2D
class_name Board

@export var tile_scn = "res://board/tile_city.tscn"
@onready var width = 9
@onready var height = 6
@onready var size : Vector2 = Vector2(128, 128)
@onready var offset : Vector2 = Vector2(430 +8 , 270 -60)

var tiles :Array = []

func _ready() -> void:
	create_board()
	pass

func create_board():
	ini_tiles_array()
	for x in width:
		for y in height:
			var tile : CityTile = load(tile_scn).instantiate()
			add_child(tile)
			set_tile(x,y, tile)
			tile.set_global_position(Vector2(x,y) * size + offset)
			tile.set_text_label(str(x) + ", " + str(y))

func ini_tiles_array():
	for i in width * height:
		tiles.append(null)

func get_tile(x: int, y: int) -> CityTile:
	var idx = (y * width) + x
	return tiles[idx]

func set_tile(x: int, y: int, val: CityTile):
	var idx = (y * width) + x
	tiles[idx] = val
