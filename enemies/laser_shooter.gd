extends Node2D



func begin_laser_cycle():
	
	while true:
		await get_tree().create_timer(6.0).timeout
		$laser.fire_laser()

