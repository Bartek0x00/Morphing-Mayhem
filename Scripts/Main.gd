extends Node2D

@export var scroll_speed: float = 1

func _ready():
	if OS.get_name() != "Android":
		ProjectSettings.set_setting("display/window/stretch/aspect", 0)
		$Limit/Mobile.queue_free()
		$Boundary/Mobile.queue_free()
	switch_level()
	$AudioStreamPlayer.finished.connect(_on_audio_loop_finished)

func _on_audio_loop_finished():
	$AudioStreamPlayer.play()

func _process(_delta):
	$Score_bar.text = "Stage: {0}\nLevel: {1}\nHp: {2}/{3}".format([Score.stage + 1,\
	Score.level, $Player.health, $Player.max_health[Score.stage]])
	$Background/Layer.motion_offset.y += scroll_speed

func toggle_pause():
	if get_tree().paused == true:
		$AudioStreamPlayer.stream_paused = false
		get_tree().paused = false
		$Pause_menu.queue_free()
		$Pause.show()
	else:
		$AudioStreamPlayer.stream_paused = true
		get_tree().paused = true
		add_child(preload("res://Scenes/Pause_menu.tscn").instantiate())
		$Pause.hide()

func _on_exit_pressed():
	get_tree().quit()

func _input(event):
	if event.is_action_pressed("Pause"):
		toggle_pause()

func switch_level():
	add_child(load("res://Scenes/Level" + str(Score.level) + ".tscn").instantiate())
