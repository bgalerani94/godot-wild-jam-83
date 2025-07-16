extends CanvasLayer

@onready var name_label = $CenterContainer/VBoxContainer/CharacterName
@onready var organ_label = $CenterContainer/VBoxContainer/OrganName

func _ready():
	CharacterGenerator.generate_name()
	CharacterGenerator.current_organ_index = randi_range(0, 4)
	name_label.text = CharacterGenerator.current_character
	organ_label.text = CharacterGenerator.organs[CharacterGenerator.current_organ_index]
