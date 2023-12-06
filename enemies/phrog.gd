extends CharacterBody2D

const SPEED = -100.0
const JUMP_VELOCITY = -700.0

var jumping := false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if jumping == true:
		velocity.x = SPEED

	if is_on_floor():
		jumping = false
		velocity.x = 0
	
	if randf() > .99 and is_on_floor():
		var random_jump = randf()
		var random_speed = randf()
		if random_jump <= .33:
			velocity.y = JUMP_VELOCITY*.75
		elif random_jump >= .66:
			velocity.y = JUMP_VELOCITY*1.5
		else:
			velocity.y = JUMP_VELOCITY*1
			
			
		if random_speed <= .33:
			print("small")
		elif random_speed >= .66:
			print("large")
		else:
			print("medium")
			

		jumping = true
	move_and_slide()
		


func _on_area_body_entered(body):
	if body.is_in_group("player"):
		body.game_over()
	if body.is_in_group("hook"):
		$death.play()
		await get_tree().create_timer(.1).timeout
		queue_free()