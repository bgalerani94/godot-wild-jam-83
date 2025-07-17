class_name OrganComponent
extends Node

@export var max_health: float
@export var health : float
@onready var organ_name_label = $OrganStats/Control/MarginContainer/ElementsContainer/OrganNameLabel
@onready var organ_health_bar = $OrganStats/Control/MarginContainer/ElementsContainer/OrganHealthBar

signal health_depleted

func _ready():
	health = max_health
	organ_health_bar.max_value = max_health
	organ_health_bar.value = health

func deplete_health(amount : float):
	health -= amount
	update_display()
	if health <= 0:
		health = 0
		health_depleted.emit()

func update_display():
	organ_health_bar.value = health
