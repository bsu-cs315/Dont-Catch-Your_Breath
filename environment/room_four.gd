extends Node2D

var player = preload("res://player_characters/player_character_one/player_character_one.tscn")
var spawner = preload("res://objects/spawner.tscn")
var protect_point = preload("res://objects/protect_point.tscn")
var next_level = "res://environment/room_five.tscn"

var protect_point_instance = protect_point.instantiate()
var player_instance = player.instantiate()
var spawner_instance = spawner.instantiate()


func _ready():
	player_instance.global_position = $spawns/player_spawn.position
	spawner_instance.global_position = $spawns/spawner_spawn.position
	protect_point_instance.global_position = $spawns/protect_point_spawn.position
	add_child(protect_point_instance)
	add_child(player_instance)
	add_child(spawner_instance)



func _on_exit_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(next_level)
