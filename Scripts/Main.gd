extends Node2D

func _ready():
	if OS.get_name() != "Android":
		$Limit/Mobile.queue_free()
	add_child(load("res://Scenes/Level" + str(Score.level) + ".tscn").instantiate())

func _process(_delta):
	$Score_bar.text = "Level: {0}\nHp: {1}/{2}".format([Score.level, \
	$Player.health, $Player.max_health])

func toggle_pause():
	if get_tree().paused == true:
		get_tree().paused = false
		$Pause_menu.hide()
		$Pause.show()
	else:
		get_tree().paused = true
		$Pause_menu.show()
		$Pause_menu/Resume.grab_focus()
		$Pause.hide()

func _on_exit_pressed():
	get_tree().quit()

func _input(event):
	if event.is_action_pressed("Pause"):
		toggle_pause()
