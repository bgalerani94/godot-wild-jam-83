extends CharacterBody2D

var player 
var speed : int = 150

func _ready():
	player = get_tree().get_first_node_in_group("Player")

func _process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
