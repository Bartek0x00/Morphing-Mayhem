extends Node2D

func _ready():
	var color_rect = ColorRect.new()
	color_rect.color = Color(0, 0, 0, 0.73)
	color_rect.size = Vector2(640, 128)
	color_rect.position = Vector2(0, 480)
	
	var ls = LabelSettings.new()
	ls.font_size = 64
	var label = Label.new()
	label.text = get_name()
	label.size = Vector2(200, 88)
	label.position = Vector2(220, 16)
	label.label_settings = ls
	
	color_rect.add_child(label)
	add_child(color_rect)

func _process(_delta):
	if get_children().size() == 1:
		var timer = Timer.new()
		add_child(timer)
		timer.start(1)
		if timer.timeout:
			Score.add_level()
			queue_free()
