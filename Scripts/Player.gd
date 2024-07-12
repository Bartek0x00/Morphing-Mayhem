extends CharacterBody2D

@export var speed: int = 200
@export var bullet_speed: Array[int] = [600, 800, 1000]
@export var cooldown: Array[float] = [1, 0.5, 0.25]
@export var max_health: Array[int] = [3, 4, 5]
@export var invincibilty: float = 1.0
var health: int = max_health[Score.stage]
const MAX_LEVEL: int = 3
var lastTime: float = 0
var isInvincible: bool = false

func _ready():
	Score.stage_changed.connect(_on_stage_changed)
	_on_stage_changed()

func damage() -> void:
	if not isInvincible:
		if (health - 1) > 0:
			health -= 1
			isInvincible = true
			var timer = get_tree().create_timer(invincibilty)
			timer.timeout.connect(_on_invincible_timeout)
			modulate_opacity(invincibilty)
			$AudioStreamPlayer.play()
			Input.vibrate_handheld(500)
		else:
			get_tree().change_scene_to_file("res://Scenes/Defeat.tscn")

func modulate_opacity(time: float) -> void:
	var tween = get_tree().create_tween()
	for i in range(time * 2):
		tween.tween_property($Sprite, "modulate:a", 0, (time / 4))
		tween.play()
		
		tween.tween_property($Sprite, "modulate:a", 1, (time / 4))
		tween.play()

func _on_invincible_timeout() -> void:
	isInvincible = false;

func shoot() -> void:
	var currentTime = Time.get_ticks_msec() / 1000.0
	if currentTime - lastTime >= cooldown[Score.stage]:
		var bullet = preload("res://Scenes/Player_bullet.tscn").instantiate()
		bullet.position = $Marker.global_position
		bullet.get_node("Sprite").frame = Score.stage
		bullet.speed = bullet_speed[Score.stage]
		get_parent().add_child(bullet)
		lastTime = currentTime

func double_shoot() -> void:
	var currentTime = Time.get_ticks_msec() / 1000.0
	if currentTime - lastTime >= cooldown[Score.stage]:
		var left_bullet = preload("res://Scenes/Player_bullet.tscn").instantiate()
		var right_bullet = preload("res://Scenes/Player_bullet.tscn").instantiate()
		left_bullet.position = $Left_marker.global_position
		right_bullet.position = $Right_marker.global_position
		left_bullet.get_node("Sprite").frame = Score.stage
		right_bullet.get_node("Sprite").frame = Score.stage
		left_bullet.speed = bullet_speed[Score.stage]
		right_bullet.speed = bullet_speed[Score.stage]
		get_parent().add_child(left_bullet)
		get_parent().add_child(right_bullet)
		lastTime = currentTime

func _physics_process(_delta):
	if Input.is_action_pressed("Shoot"):
		if Score.stage != 2:
			shoot()
		else:
			double_shoot()
	if Input.is_action_pressed("Left"):
		velocity.x = -speed
	elif Input.is_action_pressed("Right"):
		velocity.x = speed
	else:
		velocity.x = 0
	if Input.is_action_pressed("Up"):
		velocity.y = -speed
	elif Input.is_action_pressed("Down"):
		velocity.y = speed
	else:
		velocity.y = 0
	velocity.clamp(Vector2(-speed, -speed), Vector2(speed, speed))
	move_and_slide()

func _on_stage_changed() -> void:
	$Sprite.stop()
	$Sprite.play("Idle" + str(Score.stage + 1))
	health = max_health[Score.stage]
