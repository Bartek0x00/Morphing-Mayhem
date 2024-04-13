extends Control

func _ready():
	$Accept.grab_focus()
	$Accept.pressed.connect(_on_accept_pressed)

func _on_accept_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
