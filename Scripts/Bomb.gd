extends Area2D

@export var speed: int = 300

func _ready():
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)

func _physics_process(delta):
	position.y += speed * delta

func _on_area_entered(area: Node2D) -> void:
	if area.is_in_group("Player_bullet"):
		var bomb_explosion = preload("res://Scenes/Bomb_explosion.tscn").instantiate()
		bomb_explosion.position = global_position
		get_parent().add_child(bomb_explosion)
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.damage()
	if body.is_in_group("Environment"):
		var bomb_explosion = preload("res://Scenes/Bomb_explosion.tscn").instantiate()
		bomb_explosion.position = global_position
		get_parent().add_child(bomb_explosion)
	queue_free()
