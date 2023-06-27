extends Button



func _on_Resetar_button_up():
	get_tree().paused = false
	get_tree().reload_current_scene()

