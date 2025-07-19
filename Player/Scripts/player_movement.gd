extends CharacterBody2D

@export var speed = 200.0

var was_moving : bool = false

signal player_moved

func _physics_process(delta: float) -> void:
	var movement_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")	
	velocity = movement_vector * speed	
	move_and_collide(velocity * delta)	
	look_at(get_global_mouse_position())

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		pass
	else:
		pass#queue_free()

	if velocity != Vector2.ZERO:
		if !was_moving:
			was_moving = true
			player_moved.emit()
	else:
		was_moving = false
	
	
func is_moving() -> bool:
	return velocity != Vector2.ZERO
