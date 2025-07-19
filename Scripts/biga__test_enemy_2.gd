extends CharacterBody2D

@export var bulletScn: PackedScene
@export var speed := 150
@export var stop_distance := 150
var player : Node2D
var shoot = true;

func _ready():
	player = get_node_or_null("../Player")
	if not player:
		player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta):
	if not player:
		return
	
	var distance_target = global_position.distance_to(player.global_position)
	var direction = (player.global_position - global_position).normalized()
	
	if distance_target > stop_distance:
		velocity = direction * speed
	elif distance_target < stop_distance:
		velocity = -direction * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	
	if distance_target < stop_distance:
		if shoot:
			fire()
			shoot = false
		
func fire() -> void:
	var bullet = bulletScn.instantiate()
	bullet.position = global_position
	get_tree().current_scene.add_child(bullet)
	var direction = (player.global_position - global_position).normalized()
	bullet.apply_impulse(direction * 1000)


func _on_shoot_timer_timeout() -> void:
	shoot = true
