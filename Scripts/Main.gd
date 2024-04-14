extends Node2D

@export var scroll_speed: float = 1

func _ready():
	if OS.get_name() != "Android":
		$Limit/Mobile.queue_free()
		$Boundary/Mobile.queue_free()
	switch_level()

func _process(_delta):
	$Score_bar.text = "Stage: {0}\nLevel: {1}\nHp: {2}/{3}".format([Score.stage + 1,\
	Score.level, $Player.health, $Player.max_health[Score.stage]])
	$Background/Layer.motion_offset.y += scroll_speed

func toggle_pause():
	var pause_menu = preload("res://Scenes/Pause_menu.tscn").instantiate()
	if get_tree().paused == true:
		get_tree().paused = false
		remove_child(pause_menu)
		$Pause.show()
	else:
		get_tree().paused = true
		add_child(pause_menu)
		$Pause.hide()

func _on_exit_pressed():
	get_tree().quit()

func _input(event):
	if event.is_action_pressed("Pause"):
		toggle_pause()

func switch_level():
	add_child(load("res://Scenes/Level" + str(Score.level) + ".tscn").instantiate())
