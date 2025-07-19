extends CharacterBody2D

@export var speed := 150
var player : Node2D

func _ready():
	player = get_node_or_null("../Player")
	if not player:
		player = get_tree().get_first_node_in_group("Player")
	

func _physics_process(delta):
	if not player:
		return
	
	var distance_target = global_position.distance_to(player.global_position)
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
