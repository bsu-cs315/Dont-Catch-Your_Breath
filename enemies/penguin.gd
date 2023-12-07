extends CharacterBody2D


const SPEED = 100.0
var laser_starter = 1



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if (laser_starter ==1):
		$laser_shooter.begin_laser_cycle()
		laser_starter = laser_starter - 1
	velocity.x = -SPEED
	

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
		
		
