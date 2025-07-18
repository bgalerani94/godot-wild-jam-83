extends CanvasLayer

@onready var name_label = %CharacterName
@onready var organ_label = %OrganName
@onready var animation_player: AnimationPlayer = %AnimationPlayer

func play_transition(new_name, new_organ : String):
	name_label.text = new_name
	organ_label.text = new_organ
	visible = true
	animation_player.play("fade_in")
	await get_tree().create_timer(3).timeout
	animation_player.play("fade_out")
	await animation_player.animation_finished
	
	SceneManager.current_state = SceneManager.GameState.PLAYING
