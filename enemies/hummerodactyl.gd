extends CharacterBody2D

const SPEED = 200.0
var moving_left_tracker := true
var start_point_tracker := false


var player_position
var protect_point_position
var player_lock_position
var target_position

var new_player_position_x = 0
var new_player_position_y = 0
#


@onready var player = get_parent().get_parent().get_parent().get_node("player_character_one")
@onready var protect_point = get_parent().get_parent().get_parent().get_node("protect_point")


	
func _physics_process(_delta):

	new_player_position_x = player.position.x + 469.5
	new_player_position_y = player.position.y - 300
	
	player_position = Vector2(new_player_position_x, new_player_position_y)

	
	player_lock_position = (player_position - position).normalized()
	
	protect_point_position = protect_point.position
	target_position = (protect_point_position - position).normalized()
	if start_point_tracker == false:
		velocity = player_lock_position * SPEED
		if position.normalized().distance_to(player_lock_position) < 1.5:
			velocity = Vector2(0,0)
			start_point_tracker = true
		move_and_slide()
	else:
		if self.position.distance_to(protect_point_position) > 100:
			if moving_left_tracker == true:
				velocity.x = -SPEED + player.velocity.x*.1
				move_and_slide()
				if self.position.x - player.position.x < -450:
					velocity.x = 0
					velocity.y = 50
					move_and_slide()
					await get_tree().create_timer(0.5).timeout
					velocity.y = 0
					moving_left_tracker = false
					
			else:
				velocity.x = SPEED + player.velocity.x*.1
				move_and_slide()
				if self.position.x - player.position.x > 450:
					velocity.x = 0
					velocity.y = 50
					move_and_slide()
					await get_tree().create_timer(0.5).timeout
					velocity.y = 0
					moving_left_tracker = true

			move_and_slide()
		else:
			velocity = target_position*SPEED
			move_and_slide()

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

		
