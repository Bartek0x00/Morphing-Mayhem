extends VBoxContainer

var buttons = {}
var labels = {}
var waiting_for_input = false
var current_action = ""

func _ready():
	get_window().get_node("Settings/Exit").pressed.connect(_on_exit_pressed)
	for child in get_children():
		if child is HBoxContainer:
			var name = child.get_name()
			buttons[name] = child.get_node("Assign")
			labels[name] = child.get_node(str(name))
			buttons[name].pressed.connect(_on_action_button_pressed.bind(name))
			var event = InputMap.action_get_events(name)[0]
			labels[name].text = str(name) + ": " + event.as_text()
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("Pause"):
		_on_exit_pressed()
	if waiting_for_input:
		if event is InputEventKey and event.pressed:
			InputMap.action_erase_events(current_action)
			InputMap.action_add_event(current_action, event)
			var assigned = InputMap.action_get_events(current_action)[0]
			labels[current_action].text = str(current_action) + ": " + assigned.as_text()
			waiting_for_input = false

func _on_action_button_pressed(action_name):
	waiting_for_input = true
	current_action = action_name
	labels[current_action].text = "Press a key..."

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Start_menu.tscn")
