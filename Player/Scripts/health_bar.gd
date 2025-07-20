extends ProgressBar

@onready var death_audio_player = $"../../DeathAudioPlayer"
@onready var organ_damage_component: DamageComponent = $"../../OrganDamageComponent"


signal player_died
signal player_damaged

func _ready() -> void:
	organ_damage_component.on_consumed.connect(heal)

func heal(amount:float) -> void:
	value += amount

func take_damage(damage:float) -> void:
	value -= damage
	player_damaged.emit()
	if(value <= 0):
		player_died.emit()
