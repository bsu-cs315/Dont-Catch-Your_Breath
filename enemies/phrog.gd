extends CharacterBody2D

const SPEED = -125.0
const JUMP_VELOCITY = -700.0

var jumping := false

var direction_speed = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


@onready var player = get_parent().get_parent().get_parent().get_node("player_character_one")

func _physics_process(delta):
	

	if self.position.x-player.position.x > 1:
		$animation_player.flip_h = false
		direction_speed = SPEED
			
	elif self.position.x-player.position.x < 1:
		$animation_player.flip_h = true
		direction_speed = -SPEED

	if not is_on_floor():
		velocity.y += gravity * delta
		$animation_player.animation = "jump"

	if jumping == true:
		velocity.x = direction_speed

	if is_on_floor():
		jumping = false
		velocity.x = 0
		$animation_player.animation = "sit"
	
	if randf() > .99 and is_on_floor():
		var random_jump = randf()
		if random_jump <= .33:
			velocity.y = JUMP_VELOCITY*.75
		elif random_jump >= .66:
			velocity.y = JUMP_VELOCITY*1.5
		else:
			velocity.y = JUMP_VELOCITY*1
			
			
		jumping = true
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
