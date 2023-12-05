extends RayCast2D

var is_casting := false
var is_already_casting := false
var updatable :=false

func _ready() -> void:
	set_physics_process(false)
	$line.points[1] = Vector2.ZERO
	$laser_particles.reset()

func fire_laser() ->void:
	is_casting = true
	set_is_casting(is_casting)
	await get_tree().create_timer(.4).timeout
	is_casting = false

func _physics_process(_delta: float) -> void:
	var cast_point := target_position
	force_raycast_update()
	if is_colliding():
		if is_already_casting == false:
			if is_casting == true:
				cast_point = to_local(get_collision_point())
				print("hi")
				$laser_position.laser_swipe(cast_point)
				set_is_already_casting(true)
	if updatable == true:
		print ($laser_position.position)
		$line.points[1] = $laser_position.position
	else:
		$line.points[1] = Vector2.ZERO

func update_line_point(cast: bool):
	updatable = cast


func set_is_already_casting(cast: bool) -> void:
	is_already_casting = cast
	
func set_is_casting(cast: bool) -> void:
	is_casting = cast
	

	if is_casting == true:
		$line.appear()
		$laser_particles.reset()
		
	else:
		$line.disappear()



	set_physics_process(is_casting)
	
