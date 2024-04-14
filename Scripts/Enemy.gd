extends Area2D

@export var speed: int = 50
@export var stage: int = 1
@export var cooldown: int = 4
@export var max_health: int = 3
@export var max_stage: int = 3
@export var bullet_scale: Vector2 = Vector2(1, 1)

var direction: int = 1
var health: int
var lastTime: float = 0

func _ready():
	health = max_health
	$Health_bar.max_value = max_health

func _process(_delta):
	$Health_bar.value = health
	var currentTime = Time.get_ticks_msec() / 1000.0
	if currentTime - lastTime >= cooldown:
		var bullet = preload("res://Scenes/Bomb.tscn").instantiate()
		bullet.position = $Marker.global_position
		bullet.scale = bullet_scale
		get_window().get_node("Main").add_child(bullet)
		lastTime = currentTime

func _physics_process(delta):
	get_parent().progress += direction * speed * delta

func damage() -> void:
	if (health - 1) > 0:
		health -= 1
		return 
	if stage < max_stage:
		var succesor = load("res://Scenes/Enemy" + str(stage + 1) + ".tscn").instantiate()
		succesor.global_position = global_position
		succesor.max_stage = max_stage
		get_window().get_node("Main").add_child(succesor)
	get_parent().get_parent().get_parent().queue_free()
