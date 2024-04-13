extends Control

func _ready():
	$Try_again.grab_focus()

func _on_try_again_pressed():
	Score.reset()
	get_tree().change_scene_to_file("res://Scenes/Start_menu.tscn")

func _on_exit_pressed():
	get_tree().quit()
