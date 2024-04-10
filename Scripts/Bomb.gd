extends Area2D

@export var speed: int = 300

func _ready():
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)

func _physics_process(delta):
	position.y += speed * delta

func _on_area_entered(area: Node2D) -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
