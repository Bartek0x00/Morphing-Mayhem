extends Node2D

func _ready():
	var color_rect = ColorRect.new()
	color_rect.color = Color(0, 0, 0, 0.73)
	color_rect.size = Vector2(640, 128)
	color_rect.position = Vector2(0, 480)
	
	var ls = LabelSettings.new()
	ls.font_size = 64
	var label = Label.new()
	label.text = "Level" + str(Score.level)
	label.size = Vector2(200, 88)
	label.position = Vector2(220, 16)
	label.label_settings = ls
	
	color_rect.add_child(label)
	add_child(color_rect)
	var tween = get_tree().create_tween()
	tween.tween_property(color_rect, "modulate", Color(0, 0, 0, 0), 3)
	tween.tween_callback(color_rect.queue_free)

func _process(_delta):
	if get_children().size() == 0:
		var level_timer = Timer.new()
		add_child(level_timer)
		level_timer.start(1)
		level_timer.timeout.connect(_on_level_timeout)

func _on_level_timeout() -> void:
	Score.add_level()
	queue_free()
	get_parent().switch_level()
