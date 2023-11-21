extends RayCast2D

var is_casting := false

func _ready() -> void:
	set_physics_process(false)
	$line.points[1] = Vector2.ZERO
	
func fire_laser() ->void:
	
	is_casting = true
	set_is_casting(is_casting)
	

func _physics_process(_delta: float) -> void:
	var cast_point := target_position
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
	$line.points[1] = cast_point
	
func set_is_casting(cast: bool) -> void:
	is_casting = cast
	
	$laser_particles.emitting = is_casting
	if is_casting == true:
		appear()
		print("hi")
	else:
		disappear()
	set_physics_process(is_casting)
	
func appear() -> void:
	get_tree().create_tween().stop()
	get_tree().create_tween().tween_property($line, "width", 0, 10.0)
	get_tree().create_tween().play()

func disappear() -> void:
	get_tree().create_tween().stop()
	get_tree().create_tween().tween_property($line, "width", 10.0, 0)
	get_tree().create_tween().play()
