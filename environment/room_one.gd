extends Node2D

var player = preload("res://player_characters/player_character_one/player_character_one.tscn")
var protect_point = preload("res://objects/protect_point.tscn")
var spawner = preload("res://objects/spawner.tscn")

var protect_point_instance = protect_point.instantiate()
var player_instance = player.instantiate()
var spawner_instance = spawner.instantiate()


func _ready():
	player_instance.global_position = Vector2(100,200)
	spawner_instance.global_position = Vector2(1000,400)
	protect_point_instance.global_position = Vector2(100,570)
	add_child(protect_point_instance)
	add_child(player_instance)
	add_child(spawner_instance)

