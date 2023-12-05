extends Marker2D

func laser_swipe(cast_point):
	var static_cast_point = cast_point
	self.position = Vector2(static_cast_point.x, static_cast_point.y+50)
	var new_point = Vector2(cast_point.x,0)
	

	
	var tween = create_tween()
	$"..".update_line_point(true)
	tween.tween_property(self, "position", new_point, .4).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(.4).timeout
	$"..".update_line_point(false)
	$"..".set_is_already_casting(false)
	self.position = Vector2(0,0)


