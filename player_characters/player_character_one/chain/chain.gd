extends Node2D

@onready var links = $links
var direction := Vector2(0,0)
var tip := Vector2(0,0)


const SPEED = 50

var flying = false
var hooked = false

var shot = false

func shoot(dir: Vector2) -> void:
	shot = true
	$release_timer.start(5)
	$tip/collision.disabled = false 
	$tip/area/collision.disabled = false
	direction = dir.normalized()	
	flying = true					
	tip = self.global_position		




	

func timed_release():
	$release_timer.start(.2)
	print("hi")
	
	

func release():
	shot = false
	tip = self.global_position
	flying = false	
	hooked = false	

func _process(_delta: float) -> void:
	print($release_timer.time_left)
	
	if Input.is_action_just_released("click"):
		$release_timer.stop()
		shot = false

	if $release_timer.is_stopped():
		if shot == true:
			tip = self.global_position
			flying = false	
			hooked = false	
	
	self.visible = flying or hooked
	if not self.visible:
		$tip/collision.disabled = true 
		$tip/area/collision.disabled = true
		return
	var tip_loc = to_local(tip)

	links.rotation = self.position.angle_to_point(tip_loc) - deg_to_rad(270)
	$tip.rotation = self.position.angle_to_point(tip_loc) - deg_to_rad(270)
	links.position = tip_loc
	links.region_rect.size.y = tip_loc.length()


func _physics_process(_delta: float) -> void:
	$tip.global_position = tip
	if flying:
		if $tip.move_and_collide(direction * SPEED):
			hooked = true
			flying = false
	tip = $tip.global_position


func _on_release_timer_timeout():
		tip = self.global_position
		flying = false	
		hooked = false	
