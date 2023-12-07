extends Node2D

var player = preload("res://player_characters/player_character_one/player_character_one.tscn")
var spawner = preload("res://objects/spawner_5.tscn")
var protect_point = preload("res://objects/protect_point.tscn")
var next_level = "res://environment/room_six.tscn"

var protect_point_instance = protect_point.instantiate()
var player_instance = player.instantiate()
var spawner_instance = spawner.instantiate()
var spawner_instance_2 = spawner.instantiate()
var spawner_instance_3 = spawner.instantiate()

var flash := true

func _ready():
	player_instance.global_position = $spawns/player_spawn.position
	spawner_instance.global_position = $spawns/spawner_spawn.position
	spawner_instance_2.global_position = $spawns/spawner_spawn_2.position
	spawner_instance_3.global_position = $spawns/spawner_spawn_3.position
	protect_point_instance.global_position = $spawns/protect_point_spawn.position
	add_child(protect_point_instance)
	add_child(player_instance)
	add_child(spawner_instance)
	add_child(spawner_instance_2)
	add_child(spawner_instance_3)
	while flash == true:
		$crate_guy_text.visible = true
		await get_tree().create_timer(0.4).timeout
		$crate_guy_text.visible = false
		await get_tree().create_timer(0.2).timeout
		$crate_guy_text.visible = true
		await get_tree().create_timer(0.4).timeout
		$crate_guy_text.visible = false
		await get_tree().create_timer(0.8).timeout

func _on_exit_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(next_level)
