extends ColorRect

func _ready():
	$Resume.grab_focus()
	$Resume.pressed.connect(_on_resume_pressed)
	$Exit.pressed.connect(_on_exit_pressed)

func _on_resume_pressed() -> void:
	get_parent().toggle_pause()

func _on_exit_pressed() -> void:
	get_tree().quit()
