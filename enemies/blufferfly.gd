extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var player_position
var target_position
var flutter_track := true


@onready var player = get_parent().get_parent().get_parent().get_node("player_character_one")


func _physics_process(_delta):
	player_position = player.position
	target_position = (player_position - position).normalized()
	
	if position.distance_to(player_position) > 100:
		if flutter_track == true:
			if randf() <= .33:
				velocity = Vector2(target_position.x + 1, target_position.y) * SPEED
			elif randf() >= .66:
				velocity = Vector2(target_position.x -1, target_position.y) * SPEED
			else:
				velocity = Vector2(target_position.x, target_position.y -1) * SPEED
			flutter_track = false
			move_and_slide()
		else:
			velocity = target_position
			move_and_slide()
			flutter_track = true
		
	else:
		if flutter_track == true:
			if randf() <= .33:
				velocity = Vector2(1, 0) * SPEED
			elif randf() >= .66:
				velocity = Vector2(-1, 0) * SPEED
			else:
				velocity = Vector2(0, -1) * SPEED
			flutter_track=false
			move_and_slide()
		else:
			flutter_track = true


func _on_area_body_entered(body):
	if body.is_in_group("player"):
		body.game_over()
	if body.is_in_group("hook"):
		$area/collision.set_deferred("disabled", true)
		$collision.set_deferred("disabled", true)
		body.timed_release()
		$death.play()
		await get_tree().create_timer(.1).timeout
		queue_free()
	if body.is_in_group("protect_point"):
		body.decrement_health()
		queue_free()
