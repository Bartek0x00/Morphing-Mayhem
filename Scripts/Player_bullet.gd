extends Area2D

@export var speed: int = 600

func _ready():
	$Sprite.frame = Score.level - 1
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func _physics_process(delta):
	position.y -= delta * speed

func _on_body_entered(_body: Node2D) -> void:
	queue_free()

func _on_area_entered(area: Node2D) -> void:
	queue_free()
	area.call_deferred("damage")
