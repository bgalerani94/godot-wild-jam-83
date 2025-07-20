extends CanvasLayer

@export var rect_color : Color
@onready var color_rect = $ColorRect

func _ready():
	color_rect.color = rect_color
