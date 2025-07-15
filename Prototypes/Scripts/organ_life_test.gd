extends Node2D

var max_health : float = 100.0
var health : float
var is_draining : bool

func _ready():
	health = max_health
	$LifeBar.value = health
	$LifeBar.max_value = max_health

func _process(delta):
	if Input.is_action_pressed("fire"):
		is_draining = true
		drain_health(delta)
	if Input.is_action_just_released("fire"):
		is_draining = false
	
	if health < max_health and not is_draining:
		recover_health(delta)


func drain_health(delta):
	health -= 2.0 * delta
	$LifeBar.value = health


func recover_health(delta):
	health += 1.5 * delta
	$LifeBar.value = health
