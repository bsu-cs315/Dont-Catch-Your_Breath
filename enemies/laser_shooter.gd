extends Node2D



func begin_laser_cycle():
	while true:
		print("what of it")
		$laser.fire_laser()
		await get_tree().create_timer(6.0).timeout
