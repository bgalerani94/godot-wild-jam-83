extends CharacterBody2D

@export var speed = 200.0

func _physics_process(delta: float) -> void:
	var movement_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")	
	velocity = movement_vector * speed	
	move_and_collide(velocity * delta)	
	look_at(get_global_mouse_position())


func _on_area_2d_body_entered(body: Node2D) -> void:
	queue_free()
