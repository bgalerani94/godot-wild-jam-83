extends CanvasLayer

@export var stats : OrganComponent
@onready var organ_name_label = $Control/MarginContainer/ElementsContainer/OrganNameLabel
@onready var organ_health_bar = $Control/MarginContainer/ElementsContainer/OrganHealthBar

func _ready():
	organ_health_bar.max_value = stats.max_health
	organ_health_bar.value = stats.health

func _on_organ_health_component_update_health():
	organ_health_bar.value = stats.health
