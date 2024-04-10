extends CharacterBody2D

@export var speed: int = 150
@export var level: int = 1
@export var cooldown: float = 0.25
const MAX_LEVEL: int = 3
var lastTime: float = 0

func shoot():
	var currentTime = Time.get_ticks_msec() / 1000.0
	if currentTime - lastTime >= cooldown:
		var bullet = preload("res://Scenes/Player_bullet.tscn").instantiate()
		bullet.position = $Marker.global_position
		get_parent().add_child(bullet)
		lastTime = currentTime

func _physics_process(_delta):
	if Input.is_action_pressed("shoot"):
		shoot()
	if Input.is_action_pressed("left"):
		velocity.x = -speed
	elif Input.is_action_pressed("right"):
		velocity.x = speed
	else:
		velocity.x = 0
	if Input.is_action_pressed("up"):
		velocity.y = -speed
	elif Input.is_action_pressed("down"):
		velocity.y = speed
	else:
		velocity.y = 0
	velocity.clamp(Vector2(-speed, -speed), Vector2(speed, speed))
	move_and_slide()
