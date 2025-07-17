extends Node

@export var damage_rate : float = 1.75

var organ_to_damage : Node

func _ready():
	organ_to_damage = get_tree().get_first_node_in_group("Organ Health")

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		deal_damage(delta)

func deal_damage(delta):
	if organ_to_damage.has_method("deplete_health"):
		organ_to_damage.deplete_health(damage_rate * delta)
