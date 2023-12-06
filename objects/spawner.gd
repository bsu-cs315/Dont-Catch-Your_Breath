extends Node2D


@export var enemy_number = 20
var pressure = 0


@export var enemy_types : Array[String] = [
#	"res://enemies/penguin.tscn",
#	"res://enemies/phrog.tscn",
#	"res://enemies/blufferfly.tscn",
	"res://enemies/hummerodactyl.tscn",
]


@onready var _enemy_position := self.position
@onready var _enemies := $enemies


func _ready():
	while enemy_number > 0:
		$enemy_counter_label.text = "Enemies Left: %d" % ceil(enemy_number)
		var scene_path : String = enemy_types.pick_random()
		var object : Node2D = load(scene_path).instantiate()
		object.global_position = _enemy_position
		_enemies.add_child(object)
		await get_tree().create_timer(1.0 - pressure).timeout
		enemy_number -= 1
		pressure +=.015
	$enemy_counter_label.text = "Congrats!!"
	$win_sound.play()
	await get_tree().create_timer(20.0).timeout
	get_tree().change_scene_to_file("res://menus/menu.tscn")
