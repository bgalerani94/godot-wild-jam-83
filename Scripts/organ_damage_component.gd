class_name DamageComponent
extends Node

@export var damage_rate : float = 1.75
var can_damage : bool = false
var organ_to_damage : Node

func _ready():
	SceneManager.level_loaded.connect(get_new_target)
	get_new_target()

func _process(delta):
	if Input.is_action_pressed("ui_accept") and can_damage and SceneManager.current_state == SceneManager.GameState.PLAYING:
		deal_damage(delta)

func deal_damage(delta):
	if is_instance_valid(organ_to_damage) and organ_to_damage.has_method("deplete_health"):
		organ_to_damage.deplete_health(damage_rate * delta)
	else:
		disable_input()
		get_new_target()


func get_new_target():
	disable_input()
	if organ_to_damage:
		organ_to_damage = null
	await get_tree().create_timer(0.2).timeout
	organ_to_damage = get_tree().get_first_node_in_group("Organ Health")
	enable_input()

func enable_input():
	can_damage = true

func disable_input():
	can_damage = false
