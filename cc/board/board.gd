extends Node2D
class_name Board

@export var tile_scn = "res://board/tile_city.tscn"
@onready var sprite_background :Sprite2D = $CityBackground
@onready var width = 8
@onready var height = 8
@onready var size : Vector2 = Vector2(128, 128)
@onready var half_tile_size : Vector2 = Vector2(64, 64)
@onready var draw_offset : Vector2

var tiles :Array = []

func _ready() -> void:
	print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
	draw_offset = get_draw_offset()
	create_board()
	pass

func get_draw_offset() -> Vector2:
	var width_background = sprite_background.texture.get_width() * sprite_background.scale.x
	var height_background = sprite_background.texture.get_height() * sprite_background.scale.y
	return  sprite_background.position - Vector2(width_background/2,height_background/2) + half_tile_size

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton and event.is_pressed():
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				print("Left mouse button")
				handle_mouse_click(event.position)
			MOUSE_BUTTON_WHEEL_UP:
				print("Scroll wheel up")
			MOUSE_BUTTON_WHEEL_DOWN:
				print("Scroll wheel down")
			MOUSE_BUTTON_MIDDLE:
				print("Middle mouse button")
			MOUSE_BUTTON_RIGHT:
				print("Right mouse button")
	elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		pass

func handle_mouse_click(position : Vector2):
	var tile_position = get_tile_position(position)
	print("Tileposition Click/Unclick at: ", tile_position)
	pass	

func create_board():
	ini_tiles_array()
	for x in width:
		for y in height:
			var tile : CityTile = load(tile_scn).instantiate()
			add_child(tile)
			set_tile(x,y, tile)
			tile.set_global_position(Vector2(x,y) * size + draw_offset)
			tile.set_text_label(str(x) + ", " + str(y))

func ini_tiles_array():
	for i in width * height:
		tiles.append(null)

func get_tile(x: int, y: int) -> CityTile:
	return tiles[get_idx(x,y)]

func set_tile(x: int, y: int, tile: CityTile):
	tiles[get_idx(x,y)] = tile

func get_idx(x: int, y: int) -> int:
	return (y * width) + x
	
func get_tile_position(position : Vector2) -> Vector2:
	if not is_in_bounds(position):
		print("Clicked outside board.")
		return Vector2(-1,-1)
	var grid_position = position - draw_offset + Vector2(size.x/2, size.y/2)
	var x = floori(grid_position.x/size.x)
	var y = floori(grid_position.y/size.y)
	return Vector2(x, y)

func is_in_bounds(position : Vector2) -> bool:
	var offset = draw_offset - Vector2(size.x/2, size.y/2)
	if position.x < offset.x:
		return false
	elif position.x > (offset.x + (width * size.x)):
		return false
	elif position.y < offset.y:
		return false
	elif position.y > (offset.y + (height * size.y)):
		return false
	return true
