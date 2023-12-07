extends CharacterBody2D


func _on_area_body_entered(body):
	if body.is_in_group("hook"):
		get_parent().reset_timer()
		await get_tree().create_timer(.1).timeout
		$animation_player.animation = "turn"
		await get_tree().create_timer(.5).timeout
		$animation_player.animation = "still"
