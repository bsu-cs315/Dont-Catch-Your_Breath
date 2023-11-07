extends Control




func _on_play_pressed():
	$start_sound.play()
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://environment/room_one.tscn")


func _on_quit_pressed():
	$start_sound.play()
	await get_tree().create_timer(1.0).timeout
	get_tree().quit()
	
