extends Area2D

var speed : int = 300
var target_position : Vector2
var stoppingDistance : float = 10.0
var velocity : Vector2 = Vector2.ZERO

func _process(delta):
	var direction = (get_global_mouse_position() - position).normalized()
	var distance_to_mouse = position.distance_to(get_global_mouse_position())
	
	if distance_to_mouse > stoppingDistance:
		velocity = direction * speed
		position += velocity * delta
	else:
		velocity = Vector2.ZERO
