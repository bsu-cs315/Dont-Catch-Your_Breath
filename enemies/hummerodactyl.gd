extends CharacterBody2D


const SPEED = 200.0
var moving_left_tracker := true

var protect_point_position
var target_position

@onready var player = get_tree().get_root().get_node("room_one/player_character_one")
@onready var protect_point = get_tree().get_root().get_node("room_one/protect_point")


func _physics_process(_delta):
	protect_point_position = protect_point.position
	target_position = (protect_point_position - position).normalized()
	print(target_position)
	if self.position.distance_to(protect_point_position) > 100:
		if moving_left_tracker == true:
			velocity.x = -SPEED
			move_and_slide()
			await get_tree().create_timer(4.0).timeout
			velocity.x = 0
			velocity.y = 20
			move_and_slide()
			await get_tree().create_timer(0.5).timeout
			velocity.y = 0
			moving_left_tracker = false
		else:
			print("2")
			velocity.x = SPEED
			move_and_slide()
			await get_tree().create_timer(4.0).timeout
			velocity.x = 0
			velocity.y =20
			move_and_slide()
			await get_tree().create_timer(0.5).timeout
			velocity.y = 0
			moving_left_tracker = true

		move_and_slide()
	else:
		print("1")
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

		
