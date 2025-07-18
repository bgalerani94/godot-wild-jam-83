class_name NameGenerator
extends Node
# Organs for scene manager to load
var organs : Array = ["Stomach", "Liver", "Lungs", "Heart", "Brain"]
# List of first names for random generation
var first_names : Array = ["John", "Mary","Ryan", "Adrian", "Bruno", "Allan", "Felipe", "Joanna", "Bob", "Bogas"]
#List of last names for random generation
var last_names : Array = ["Smith", "Johnson", "Fini", "Brown", "Garcia", "Bigatto", "Williams", "Cremasco", "Galerani"]

var current_character : String = ""
var current_first_name : String = ""
var current_last_name : String = ""
var current_organ_index : int = 0
var completed_character : Array = []

func generate_name() -> String:
	current_first_name = first_names.pick_random()
	current_last_name = last_names.pick_random()
	current_character = current_first_name + " " + current_last_name
	return current_character
