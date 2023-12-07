extends Node2D

var player = preload("res://player_characters/player_character_one/player_character_one.tscn")
var spawner = preload("res://objects/spawner_4.tscn")
var spawner_2 = preload("res://objects/spawner_4_secondary.tscn")
var protect_point = preload("res://objects/protect_point.tscn")
var next_level = "res://environment/room_five.tscn"

var protect_point_instance = protect_point.instantiate()
var player_instance = player.instantiate()
var spawner_instance = spawner.instantiate()
var spawner_instance_2 = spawner_2.instantiate()

var flash := true

func _ready():
	$exit/collision.set_deferred("disabled", true)
	player_instance.global_position = $spawns/player_spawn.position
	spawner_instance.global_position = $spawns/spawner_spawn.position
	spawner_instance_2.global_position = $spawns/spawner_spawn_2.position
	protect_point_instance.global_position = $spawns/protect_point_spawn.position
	add_child(protect_point_instance)
	add_child(player_instance)
	add_child(spawner_instance)
	add_child(spawner_instance_2)
	while flash == true:
		await get_tree().create_timer(3).timeout
		$capital_label.visible = true
		await get_tree().create_timer(0.8).timeout
		$capital_label.visible = false
		await get_tree().create_timer(0.4).timeout
		$capital_label.visible = true
		await get_tree().create_timer(0.8).timeout
		$capital_label.visible = false

func _on_exit_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(next_level)
