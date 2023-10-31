extends Node2D

@onready var links = $links
var direction := Vector2(0,0)
var tip := Vector2(0,0)


const SPEED = 50

var flying = false
var hooked = false

func shoot(dir: Vector2) -> void:
	
	direction = dir.normalized()	
	flying = true					
	tip = self.global_position		


func release() -> void:
	tip = self.global_position		
	flying = false	
	hooked = false	


func _process(_delta: float) -> void:
	self.visible = flying or hooked
	if not self.visible:
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
