extends Marker2D

@export var bulletScn: PackedScene

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("fire")):
		fire()
		
func fire() -> void:
	var bullet = bulletScn.instantiate()
	bullet.position = global_position
	get_tree().current_scene.add_child(bullet)
	var mouse_pos = get_viewport().get_camera_2d().get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	bullet.apply_impulse(direction * 1000)
