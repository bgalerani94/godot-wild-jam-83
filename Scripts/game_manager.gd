class_name GameManager
extends Node

var character_name : String
var current_organ : String


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
		updated_screen.play_transition(character_name, current_organ)

#Instancia cena do orgão atual
func load_level(organ_scene_name : String):
	organ_scene_name = str(CharacterGenerator.organs[CharacterGenerator.current_organ_index])
