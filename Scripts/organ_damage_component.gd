class_name DamageComponent
extends Node

@onready var player: CharacterBody2D = $".."

@export var damage_rate : float = 1.75
var input_enabled : bool = false
var damage_enabled : bool = false
var is_damaging : bool = false
var organ_to_damage : Node

func _ready():
	player.player_moved.connect(player_moved)
	SceneManager.level_loaded.connect(get_new_target)
	get_new_target()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and !player.is_moving():
		damage_enabled = true
	
	if Input.is_action_just_released("ui_accept"):
		damage_enabled = false
		is_damaging = false
		
	if Input.is_action_pressed("ui_accept") and can_do_damage():
		deal_damage(delta)

func deal_damage(delta):
	if is_instance_valid(organ_to_damage) and organ_to_damage.has_method("deplete_health"):
		organ_to_damage.deplete_health(damage_rate * delta)
		is_damaging = true
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
	input_enabled = true

func disable_input():
	input_enabled = false

func player_moved():
	damage_enabled = false

func can_do_damage() -> bool:
	return input_enabled and damage_enabled and SceneManager.current_state == SceneManager.GameState.PLAYING and !player.is_moving()
