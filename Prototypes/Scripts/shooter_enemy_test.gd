extends CharacterBody2D

var speed : int = 200
var stopping_distance : float = 400.0
var player

func _ready():
	player = get_tree().get_first_node_in_group("Player")


func _physics_process(delta):
	var direction = (player.global_position - global_position).normalized() 
	var distance_to_player = global_position.distance_to(player.global_position)
	if distance_to_player > stopping_distance:
		velocity = direction * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO
