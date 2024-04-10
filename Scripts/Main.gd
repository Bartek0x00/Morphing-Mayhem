extends Node2D

func _on_resume_pressed():
	get_tree().paused = false
	$Pause.show()
	$Pause_menu.hide()

func _on_pause_pressed():
	$Pause.hide()
	$Pause_menu.show()
	get_tree().paused = true

func _on_exit_pressed():
	get_tree().quit()
