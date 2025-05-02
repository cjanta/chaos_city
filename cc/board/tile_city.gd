extends Node2D
class_name CityTile

@onready var coord_text : Label = $Label
@onready var sprite_background : Sprite2D = $"128"

func _ready() -> void:
	sprite_background.modulate = Color(randf(),randf(),randf(),1.0)
	pass
	
func set_text_label(text) -> void:
	coord_text.set_text(text)
