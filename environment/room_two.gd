extends Node2D

var player = preload("res://player_characters/player_character_one/player_character_one.tscn")
var protect_point = preload("res://objects/protect_point.tscn")
var spawner = preload("res://objects/spawner_2.tscn")
var next_level = "res://environment/room_three.tscn"

var protect_point_instance = protect_point.instantiate()
var player_instance = player.instantiate()
var spawner_instance = spawner.instantiate()

var flash := true
var i := 0



func _ready():
	player_instance.global_position = $spawns/player_spawn.position
	spawner_instance.global_position = $spawns/spawner_spawn.position
	protect_point_instance.global_position = $spawns/protect_point_spawn.position
	add_child(protect_point_instance)
	add_child(player_instance)
	add_child(spawner_instance)
	while flash == true:
		await get_tree().create_timer(3).timeout
		$help_label.visible = true
		await get_tree().create_timer(0.8).timeout
		$help_label.visible = false
		await get_tree().create_timer(0.4).timeout
		$help_label.visible = true
		await get_tree().create_timer(0.8).timeout
		$help_label.visible = false

		
	
func on_exit():
	flash = false
	$help_label.set_text("THANK THE HEAVENS!!!")
	$help_label.visible = true
	await get_tree().create_timer(5).timeout
	$help_label.visible = true
	$help_label.set_text("Bless you Javeleis!")
	await get_tree().create_timer(3).timeout
	$help_label.visible = true
	$help_label.set_text("Follow me! The water plant is in danger!!!")
	await get_tree().create_timer(3).timeout
	$help_label.visible = true
	$help_label.set_text("Let's see what that toy is made of (:<")
	while i < 250:
		$crate_guy.flip_h = true
		$crate_guy.position = Vector2($crate_guy.position.x - 1, $crate_guy.position.y)
		await get_tree().create_timer(.001).timeout
		i+= 1
	get_tree().change_scene_to_file(next_level)
