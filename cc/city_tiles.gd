extends TileMapLayer
class_name SceneTileMapLayer

var scene_coords: Dictionary = {}

func _enter_tree():
	child_entered_tree.connect(_register_child)
	child_exiting_tree.connect(_unregister_child)

func _register_child(child):
	await child.ready
	var coords = local_to_map(to_local(child.global_position))
	scene_coords[coords] = child
	child.set_meta("tile_coords", coords)

func _unregister_child(child):
	scene_coords.erase(child.get_meta("tile_coords"))

func get_cell_scene(coords: Vector2i) -> Node:
	return scene_coords.get(coords, null)

func _init():
	pass

func _ready():
	for v2 in get_used_cells():
		var cell = get_cell_scene(v2)
		cell.set_text_label("h")
		

	
