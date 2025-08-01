class_name GameManager
extends Node

var character_name : String
var current_organ : String

enum GameState {PLAYING, TRANSITION}
var current_state : GameState = GameState.TRANSITION

const STOMACH = preload("res://Scenes/stomach.tscn")
const LIVER = preload("res://Scenes/liver.tscn")
const LUNGS = preload("res://Scenes/lungs.tscn")
const HEART = preload("res://Scenes/heart.tscn")
const BRAIN = preload("res://Scenes/brain.tscn")
const NAME_DISPLAY = preload("res://UI/Scenes/name_display.tscn")

var current_organ_instance = null
var organ_health_component : OrganComponent = null
var player : CharacterBody2D
var health_bar : ProgressBar
var damage_component : DamageComponent
var is_first_organ : bool = true

signal level_loaded
	
func start_game():	
	is_first_organ = true
	generate_character_info()
	load_level()
	load_transition_scene()

	if get_tree().current_scene.scene_file_path != "res://Prototypes/Scenes/test_scene.tscn":	
		await get_tree().change_scene_to_file("res://Prototypes/Scenes/test_scene.tscn")
		await get_tree().process_frame
		await get_tree().process_frame
		CharacterGenerator.completed_character.clear()
			
	player = get_tree().get_first_node_in_group("Player")
	health_bar = player.get_node("HealthBarHolder/HealthBar")
	damage_component = player.get_node("OrganDamageComponent")	
	health_bar.player_died.connect(on_player_died)	

# Função de gerar personagem 
func generate_character_info():
	CharacterGenerator.generate_name()
	character_name = CharacterGenerator.current_character
	current_organ = CharacterGenerator.organs[CharacterGenerator.current_organ_index]

#Instacia tela de transição com nome de personagem e orgão atual
func load_transition_scene():
	var transition_scene = preload("res://UI/Scenes/transition_screen.tscn")
	var updated_screen = transition_scene.instantiate()
	add_child(updated_screen)
	if updated_screen.has_method("play_transition"):
		updated_screen.play_transition(character_name, current_organ, is_first_organ)
	is_first_organ = false

# Função para obter nome correto do orgão
func get_organ_scene(_organ_name : String):
	match _organ_name.to_lower():
		"stomach":
			return STOMACH
		"liver":
			return LIVER
		"lungs":
			return LUNGS
		"heart":
			return HEART
		"brain":
			return BRAIN

#Instancia cena do orgão atual
func load_level():
	var organ_name = str(CharacterGenerator.organs[CharacterGenerator.current_organ_index])
	var organ_scene = get_organ_scene(organ_name)
	current_organ = organ_name
	
	# Checa se há um orgão já carregado e deleta antes de instanciar outro
	if current_organ_instance:
		if organ_health_component.has_signal("health_depleted"):
			organ_health_component.health_depleted.disconnect(_on_organ_health_depleted)
		current_organ_instance.queue_free()

# Instancia nova cena de orgão
	current_organ_instance = organ_scene.instantiate()
	if current_organ_instance.has_method("get_health_component"):
		organ_health_component = current_organ_instance.get_health_component()
		
	add_child(current_organ_instance)
	if organ_health_component.has_signal("health_depleted"):
		organ_health_component.health_depleted.connect(_on_organ_health_depleted)
	level_loaded.emit()

func _on_organ_health_depleted():	
	var enemies_loaded = get_tree().get_nodes_in_group("Enemy")
	for enemy in enemies_loaded:
		enemy.queue_free()
	
	damage_component.disable_input()
	current_state = GameState.TRANSITION
	
	CharacterGenerator.current_organ_index += 1
	
	if CharacterGenerator.current_organ_index >= CharacterGenerator.organs.size():
		CharacterGenerator.completed_character.append(character_name)
		print(CharacterGenerator.completed_character)
		CharacterGenerator.current_organ_index = 0
		generate_character_info()
		load_level()
		load_transition_scene()
	else:
		load_level()
		load_transition_scene()
		
func on_player_died() -> void:
	current_organ_instance.queue_free()
	get_tree().change_scene_to_packed(NAME_DISPLAY)
