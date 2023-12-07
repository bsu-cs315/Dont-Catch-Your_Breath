extends Node2D


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("change_to_one"):
		get_tree().change_scene_to_file("res://environment/room_one.tscn")
	if Input.is_action_just_pressed("change_to_two"):
		get_tree().change_scene_to_file("res://environment/room_two.tscn")
	if Input.is_action_just_pressed("change_to_three"):
		get_tree().change_scene_to_file("res://environment/room_three.tscn")
	if Input.is_action_just_pressed("change_to_four"):
		get_tree().change_scene_to_file("res://environment/room_four.tscn")
	if Input.is_action_just_pressed("change_to_five"):
		get_tree().change_scene_to_file("res://environment/room_five.tscn")
	if Input.is_action_just_pressed("change_to_six"):
		get_tree().change_scene_to_file("res://environment/room_six.tscn")
