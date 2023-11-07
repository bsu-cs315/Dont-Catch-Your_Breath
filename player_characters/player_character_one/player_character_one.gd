extends CharacterBody2D

const JUMP_FORCE = 800			
const MOVE_SPEED = 100			
const GRAVITY = 50				
const MAX_SPEED = 2000			
const FRICTION_AIR = 0.95		
const FRICTION_GROUND = 0.85	
const CHAIN_PULL = 105

var chain_velocity := Vector2(0,0)
var can_jump = false		

func game_over():
		get_tree().change_scene_to_file("res://environment/room_one.tscn")
		
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
#			$grapple_shot.play()
			$chain.shoot(event.position - get_viewport().size * 0.5)

		else:
		
			$chain.release()


func _physics_process(_delta: float) -> void:

	var walk = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * MOVE_SPEED
	
	velocity.y += GRAVITY
		
	
	if $chain.hooked:
	
		chain_velocity = to_local($chain.tip).normalized() * CHAIN_PULL
		if chain_velocity.y > 0:
			
			chain_velocity.y *= 0.55
		else:
			
			chain_velocity.y *= 1.65
		if sign(chain_velocity.x) != sign(walk):
			
			chain_velocity.x *= 0.7
	else:
	
		chain_velocity = Vector2(0,0)
	velocity += chain_velocity

	velocity.x += walk
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()
	velocity.x -= walk
	

	
	velocity.y = clamp(velocity.y, -MAX_SPEED, MAX_SPEED)	
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	var grounded = is_on_floor()
	if grounded:
		velocity.x *= FRICTION_GROUND	
		can_jump = true 
		if velocity.y >= 5:		
			velocity.y = 5		
	elif is_on_ceiling() and velocity.y <= -5:	
		velocity.y = -5


	if !grounded:
		velocity.x *= FRICTION_AIR
		if velocity.y > 0:
			velocity.y *= FRICTION_AIR

	
	if Input.is_action_just_pressed("jump"):
		if grounded:
#			$jump.play()
			velocity.y = -JUMP_FORCE	
		elif can_jump:
#			$jump.play()
			can_jump = false	
			velocity.y = -JUMP_FORCE
