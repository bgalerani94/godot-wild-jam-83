extends Marker2D

@export var bulletScn: PackedScene
@onready var damage_component: DamageComponent = $"../OrganDamageComponent"
@onready var fire_audio_player = %FireAudioPlayer


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fire") and !damage_component.is_damaging:
		fire()
		
func fire() -> void:
	var bullet = bulletScn.instantiate()
	bullet.get_node("Area2D").is_player_bullet = true
	bullet.position = global_position
	get_tree().current_scene.add_child(bullet)
	var mouse_pos = get_viewport().get_camera_2d().get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	bullet.apply_impulse(direction * 1000)
	fire_audio_player.pitch_scale = randf_range(0.7, 1.45)
	fire_audio_player.play()
