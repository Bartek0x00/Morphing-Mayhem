extends Control

@onready var tree = get_tree()

func _ready():
	$Play.pressed.connect(_on_play_pressed)
	$Settings.pressed.connect(_on_settings_pressed)
	$Exit.pressed.connect(_on_exit_pressed)
	$Play.grab_focus()

func _on_play_pressed() -> void:
	tree.change_scene_to_file("res://Scenes/Introduction.tscn")

func _on_settings_pressed() -> void:
	tree.change_scene_to_file("res://Scenes/Settings.tscn")

func _on_exit_pressed() -> void:
	tree.quit()
