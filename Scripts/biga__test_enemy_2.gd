extends CharacterBody2D

@export var bulletScn: PackedScene
@export var speed := 150
@export var stop_distance := 150
@export var evade_distance := 140
var player : Node2D
var shoot = false
var canwalk = true

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
	elif distance_target < evade_distance:
		velocity = -direction * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func fire() -> void:
	var bullet = bulletScn.instantiate()
	bullet.position = global_position
	get_tree().current_scene.add_child(bullet)
	var direction = (player.global_position - global_position).normalized()
	bullet.apply_impulse(direction * 1000)


func _on_shoot_timer_timeout() -> void:
	fire()


func _on_area_2d_body_entered(body: Node2D) -> void:
	fire()
	$Shoot_Timer.start()
	shoot = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	$Shoot_Timer.stop()
	shoot = false
