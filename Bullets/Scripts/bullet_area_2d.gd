extends Area2D

var is_player_bullet : bool = false

func _on_body_entered(body: Node2D) -> void:
	if body is PhysicsBody2D:
		var layer = body.collision_layer

		if layer & (1 << 0) and !is_player_bullet:
			print("damage player")
		else: if layer & (2 << 0) and is_player_bullet:
			body.queue_free()
