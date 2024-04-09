extends Area2D

@export var speed: int = 600

func _ready():
	$Sprite.frame = Score.level - 1
	body_entered.connect(_on_body_entered)

func _physics_process(delta):
	position.y -= delta * speed

func _on_body_entered() -> void:
	queue_free()
