extends Node2D

var player = preload("res://player_characters/player_character_one/player_character_one.tscn")
var spawner = preload("res://objects/spawner_3.tscn")
var protect_point = preload("res://objects/protect_point.tscn")
var valve = preload("res://objects/valve.tscn")

var next_level = "res://environment/room_four.tscn"

var protect_point_instance = protect_point.instantiate()
var player_instance = player.instantiate()
var spawner_instance = spawner.instantiate()
var valve_instance = valve.instantiate()

var countdown := true


func _ready():
	player_instance.global_position = $spawns/player_spawn.position
	spawner_instance.global_position = $spawns/spawner_spawn.position
	protect_point_instance.global_position = $spawns/protect_point_spawn.position
	valve_instance.global_position = $spawns/valve_spawn.position
	
	add_child(protect_point_instance)
	add_child(player_instance)
	add_child(spawner_instance)
	add_child(valve_instance)
	
	while countdown == true:
		$valve_counter_label.text = str($valve_timer.time_left)
		await get_tree().create_timer(.1).timeout
		if $valve_timer.time_left == 0:
			countdown = false

	
func _on_exit_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(next_level)
		


func reset_timer():
	print(14)
	$valve_timer.start(10.0)




func _on_valve_timer_timeout():
	print("game_over")
