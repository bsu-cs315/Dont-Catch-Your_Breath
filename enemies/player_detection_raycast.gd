extends RayCast2D


func _physics_process(_delta: float) -> void:
	if is_colliding():
		print (get_collider().name)
		if get_collider().name == "player_character_one":
			get_collider().game_over()
	force_raycast_update()
	
	$Sprite2D.position = self.target_position
