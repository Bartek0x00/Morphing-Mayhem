extends RigidBody2D

func _ready():
	$Notifier.screen_exited.connect(_on_screen_exited)
	body_entered.connect(_on_body_entered)

func _on_screen_exited() -> void:
	queue_free()

func _on_body_entered() -> void:
	queue_free()
