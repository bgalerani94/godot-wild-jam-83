extends Area2D

@export var damage : float = 10
var is_player_bullet : bool = false

func _on_body_entered(body: Node2D) -> void:
	if body is PhysicsBody2D:
		var layer = body.collision_layer
		
		if layer & (1 << 0) and !is_player_bullet:
			body.get_node("HealthBarHolder/HealthBar").take_damage(damage)
			get_parent().queue_free()
		elif layer & (2 << 0) and is_player_bullet:
			body.queue_free()			
			get_parent().queue_free()
