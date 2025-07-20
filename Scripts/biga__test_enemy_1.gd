extends CharacterBody2D

@export var speed := 150
@export var damage := 15

@onready var timer: Timer = $Timer

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


func _on_area_2d_body_entered(body: Node2D) -> void:
	hit_player()
	timer.start()
	pass


func _on_area_2d_body_exited(body: Node2D) -> void:
	timer.stop()
	pass
	
func hit_player() -> void:
	player.get_node("HealthBarHolder/HealthBar").take_damage(damage)
