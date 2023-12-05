extends Line2D



func appear() -> void:
	var tween = create_tween()
	tween.tween_property(self, "width", 10, 0)
	tween.tween_property(self, "width", 0, .4).set_trans(Tween.TRANS_BOUNCE)


func disappear() -> void:
	var tween = create_tween()
	tween.tween_property(self, "width", 0, 0)

