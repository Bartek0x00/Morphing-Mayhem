extends CharacterBody2D

@export var speed: int = 150
@export var level: int = 1
const MAX_LEVEL: int = 3

func _physics_process(delta):
	if Input.is_action_pressed("left"):
		velocity.x = -speed
	elif Input.is_action_pressed("right"):
		velocity.x = speed
	else:
		velocity.x = 0
	move_and_slide()
