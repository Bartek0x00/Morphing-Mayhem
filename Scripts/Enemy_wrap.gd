extends Node2D

@export var clockwise_direction: int = 1
@export var speed: int = 150
@export var max_stage: int = 3
@onready var enemy = get_node("Path2D/PathFollow2D/Enemy")
@onready var path_follower = get_node("Path2D/PathFollow2D")

func _ready():
	enemy.speed = speed
	enemy.direction = clockwise_direction
	enemy.max_stage = max_stage
	path_follower.progress = randf()
