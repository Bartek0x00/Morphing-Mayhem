extends Node2D

@export var clockwise_direction: int = 1
@export var speed: int = 150
@export var progress: float = 0

func _ready():
	var enemy = get_node("Path2D/PathFollow2D/Enemy")
	enemy.speed = speed
	enemy.direction = clockwise_direction
	get_node("Path2D/PathFollow2D").progress = progress
