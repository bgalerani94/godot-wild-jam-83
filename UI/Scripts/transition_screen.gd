extends CanvasLayer

@onready var name_label = %CharacterName
@onready var organ_label = %OrganName
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var fake_bg: ColorRect = $FakeBg

func play_transition(new_name, new_organ : String, show_fake_bg : bool):
	fake_bg.visible = show_fake_bg
	name_label.text = new_name
	organ_label.text = new_organ
	visible = true
	
	animation_player.play("fade_in")	
	await get_tree().create_timer(3).timeout
	
	if fake_bg.visible:
		fake_bg.visible = false
	
	animation_player.play("fade_out")
	await animation_player.animation_finished
	
	SceneManager.current_state = SceneManager.GameState.PLAYING
