extends Control

@onready var page_title: Label = $VBoxContainer/TitleMarginContainer/PageTitle
@onready var grid_container: GridContainer = $VBoxContainer/NameGridMrginContainer/VBoxContainer/ScrollContainer/GridContainer

var names_array : Array

func _ready() -> void:
	page_title.text = "People Consumed: %s" %CharacterGenerator.completed_character.size() 
	
	names_array = CharacterGenerator.completed_character.duplicate()
	names_array.sort()
	setup_names(names_array)	

func setup_names(names : Array):
	# Apaga lista de nomes anteriores
	for child in grid_container.get_children():
		child.queue_free()
	
	grid_container.columns = check_columns(names.size())
	
	for name in names:
		add_new_label(name)

# Adiciona uma label nova dentro do grid
func add_new_label(name):
	var name_label = Label.new()
	name_label.text = name
	name_label.add_theme_color_override("font_color", Color.WHITE)
	name_label.add_theme_font_size_override("font_size", 30)
	grid_container.add_child(name_label)

# Checa uantidade de nomes para definir quantas colunas terá a grid
func check_columns(name_amount):
	if name_amount <= 10:
		return 2
	if name_amount <= 20:
		return 3
	else:
		return 4


func _on_play_again_button_pressed() -> void:
	print("REplaaay")
	SceneManager.start_game()
