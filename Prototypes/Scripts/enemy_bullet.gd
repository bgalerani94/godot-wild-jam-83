extends Area2D

var bullet_speed := 1000.0

func _process(delta):
	position += Vector2.RIGHT * bullet_speed * delta
