extends Node

signal stage_changed

const MAX_LEVEL: int = 6
var level: int = 3
var stage: int = 0

func reset():
	level = 1
	stage = 0

func add_level() -> void:
	level += 1
	if level % 2 == 1:
		stage += 1
		emit_signal("stage_changed")
	if level <= MAX_LEVEL:
		get_window().get_node("Main").add_child(load("res://Scenes/Level" + str(Score.level) + ".tscn").instantiate())
	else:
		get_tree().change_scene_to_file("res://Scenes/Final.tscn")
