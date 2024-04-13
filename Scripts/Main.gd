extends Node2D

@export var scroll_speed: float = 1

func _ready():
	if OS.get_name() != "Android":
		$Limit/Mobile.queue_free()
		$Boundary/Mobile.queue_free()
	add_child(load("res://Scenes/Level" + str(Score.level) + ".tscn").instantiate())

func _process(_delta):
	$Score_bar.text = "Stage: {0}\nLevel: {1}\nHp: {2}/{3}".format([Score.stage + 1,\
	Score.level, $Player.health, $Player.max_health[Score.stage]])
	$Background/Layer.motion_offset.y += scroll_speed

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
