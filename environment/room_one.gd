extends Node2D

var player = preload("res://player_characters/player_character_one/player_character_one.tscn")

var instance = player.instantiate()


# Called when the node enters the scene tree for the first time.
func _ready():
	instance.global_position = Vector2(100,200)
	add_child(instance)
	

