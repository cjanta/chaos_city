extends Node2D
class_name CityTile

@onready var coord_text : Label = $Label


func _ready() -> void:
	pass
	
func set_text_label(text) -> void:
	coord_text.set_text(text)
