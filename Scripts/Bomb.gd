extends Area2D

@export var speed: int = 300

func _ready():
	body_entered.connect(_on_body_entered)

func _physics_process(delta):
	position.y += speed * delta

func _on_body_entered() -> void:
	queue_free()
