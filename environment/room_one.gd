extends Node2D

var player = preload("res://player_characters/player_character_one/player_character_one.tscn")
var spawner = preload("res://objects/spawner.tscn")

var player_instance = player.instantiate()
var spawner_instance = spawner.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	player_instance.global_position = Vector2(100,200)
	spawner_instance.global_position = Vector2(1000,400)
	add_child(player_instance)
	add_child(spawner_instance)

