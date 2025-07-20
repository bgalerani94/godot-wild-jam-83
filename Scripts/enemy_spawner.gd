extends Path2D

const ENEMY_1 : PackedScene = preload("res://Scenes/biga__test_enemy_1.tscn")
const ENEMY_2 : PackedScene = preload("res://Scenes/biga__test_enemy_2.tscn")

var enemies : Array = [ENEMY_1, ENEMY_2]

func spawn_enemy():
	var enemy_to_spawn = enemies[randi_range(0, enemies.size() - 1)].instantiate()
	%PathFollow2D.progress_ratio = randf()
	enemy_to_spawn.global_position = %PathFollow2D.global_position
	get_tree().current_scene.add_child(enemy_to_spawn)


func _on_timer_timeout():
	spawn_enemy()
