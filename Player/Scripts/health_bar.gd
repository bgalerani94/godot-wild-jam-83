extends ProgressBar

@onready var death_audio_player = $"../../DeathAudioPlayer"

signal player_died

func take_damage(damage:float) -> void:
	value -= damage
	if(value <= 0):
		player_died.emit()
