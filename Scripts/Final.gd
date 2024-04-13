extends Control

func _ready():
	$ColorRect/Github.grab_focus()

func _on_github_pressed():
	OS.shell_open("https://github.com/Bartek0x00/Morphing-Mayhem")

func _on_exit_pressed():
	get_tree().quit()
