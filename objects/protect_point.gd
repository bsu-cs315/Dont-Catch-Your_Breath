extends CharacterBody2D


@export var health = 5

func decrement_health():
	health -= 1
	$health_label.set_text(str(health))
