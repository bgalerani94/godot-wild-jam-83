extends CanvasLayer

@onready var name_label = %CharacterName
@onready var organ_label = %OrganName
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func play_transition(new_name, new_organ : String):
	name_label.text = new_name
	organ_label.text = new_organ
	visible = true
	animation_player.play("fade_in")
