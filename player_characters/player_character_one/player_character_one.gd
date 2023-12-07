extends CharacterBody2D

const JUMP_FORCE = 800			
const MOVE_SPEED = 250			
const GRAVITY = 50				
const MAX_SPEED = 2000			
const FRICTION_AIR = 0.95		
const FRICTION_GROUND = 0.85	
const CHAIN_PULL = 105

var chain_velocity := Vector2(0,0)
var can_jump = false

var game_over_check = false

var walk_waiter = 0
var jump_waiter = 0

func game_over():
	$player_death.play()
	$animation_player.animation = "death"
	self.rotate(360)
	await get_tree().create_timer(.1).timeout
	game_over_check = true
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://menus/menu.tscn")


func _unhandled_input(event: InputEvent) -> void:
	if game_over_check == false:
		if event is InputEventMouseButton:
			if event.pressed:
				$grapple_shot.play()
				$chain.shoot(event.position - get_viewport().size * 0.5)

			else:
				$chain.release()


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
		
	if game_over_check == true:
		$animation_player.animation = "death"
	
	var walk = (Input.get_action_strength("right") - Input.get_action_strength("left")) * MOVE_SPEED
	
	if walk < 0:
		$animation_player.flip_h = true
	elif walk > 0:
		$animation_player.flip_h = false
	if game_over_check == false:
		if is_on_floor():
			if walk != 0:
				$animation_player.animation = "run"
				walk_waiter = 1
			elif walk == 0 && walk_waiter == 1:
				$animation_player.animation = "stand"
				walk_waiter = 0
				
		else:
			$animation_player.animation = "jump"
			jump_waiter = 0
			
		if jump_waiter == 0:
			if is_on_floor():
				$animation_player.animation = "stand"
				jump_waiter = 1
				
		
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
	
	if game_over_check == false:
		velocity.x += walk
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	move_and_slide()
	
	if game_over_check == false:
		velocity.x -= walk


	
	velocity.y = clamp(velocity.y, -MAX_SPEED, MAX_SPEED)	
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	var grounded = is_on_floor()
	if grounded:
		velocity.x *= FRICTION_GROUND	
		if game_over_check == false:
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
#			
			velocity.y = -JUMP_FORCE	
		elif can_jump:
			can_jump = false	
			velocity.y = -JUMP_FORCE


func _on_area_2d_body_entered(body):
	if body.is_in_group("laser"):
		self.game_over()
