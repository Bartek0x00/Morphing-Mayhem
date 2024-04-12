extends CharacterBody2D

@export var speed: int = 200
@export var bullet_speed: Array[int] = [600, 800, 1000]
@export var cooldown: Array[float] = [1, 0.5, 0.25]
@export var max_health: int = 6
var health: int = max_health
const MAX_LEVEL: int = 3
var lastTime: float = 0

func _ready():
	Score.level_changed.connect(_on_level_changed)

func damage() -> int:
	if (health - 1) > 0:
		health -= 1
		return 0
	get_tree().change_scene_to_file("res://Scenes/Final.tscn")
	return 1

func shoot() -> void:
	var currentTime = Time.get_ticks_msec() / 1000.0
	if currentTime - lastTime >= cooldown[Score.level - 1]:
		var bullet = preload("res://Scenes/Player_bullet.tscn").instantiate()
		bullet.position = $Marker.global_position
		bullet.get_node("Sprite").frame = Score.level - 1
		bullet.speed = bullet_speed[Score.level - 1]
		get_parent().add_child(bullet)
		lastTime = currentTime

func double_shoot() -> void:
	var currentTime = Time.get_ticks_msec() / 1000.0
	if currentTime - lastTime >= cooldown[Score.level - 1]:
		var left_bullet = preload("res://Scenes/Player_bullet.tscn").instantiate()
		var right_bullet = preload("res://Scenes/Player_bullet.tscn").instantiate()
		left_bullet.position = $Left_marker.global_position
		right_bullet.position = $Right_marker.global_position
		left_bullet.get_node("Sprite").frame = Score.level - 1
		right_bullet.get_node("Sprite").frame = Score.level - 1
		left_bullet.speed = bullet_speed[Score.level - 1]
		right_bullet.speed = bullet_speed[Score.level - 1]
		get_parent().add_child(left_bullet)
		get_parent().add_child(right_bullet)
		lastTime = currentTime

func _physics_process(_delta):
	if Input.is_action_pressed("shoot"):
		if Score.level != 3:
			shoot()
		else:
			double_shoot()
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

func _on_level_changed() -> void:
	$Sprite.stop()
	$Sprite.play("Idle" + str(Score.level))

