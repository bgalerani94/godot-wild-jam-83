extends Area2D

@export var bullet_speed : float = 200.0

func _process(delta):
	position += Vector2.RIGHT * bullet_speed * delta

func _on_body_entered(body : CharacterBody2D):
	if body.has_method("take_damage"):
		body.take_damage()
	queue_free()
