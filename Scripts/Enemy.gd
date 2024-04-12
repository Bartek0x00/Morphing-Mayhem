extends Area2D

var direction: int = 1
@export var speed: int = 50
@export var stage: int = 1
@export var cooldown: int = 4
@export var max_health: int = 3
@export var score: int = 3

var health: int
const MAX_STAGE: int = 3
var lastTime: float = 0

func _ready():
	health = max_health
	$Health_bar.max_value = max_health

func _process(_delta):
	$Health_bar.value = health
	var currentTime = Time.get_ticks_msec() / 1000.0
	if currentTime - lastTime >= cooldown:
		var bullet = preload("res://Scenes/Bomb.tscn").instantiate()
		bullet.global_position = $Marker.global_position
		get_window().add_child(bullet)
		lastTime = currentTime

func _physics_process(delta):
	get_parent().progress += direction * speed * delta

func damage() -> void:
	if (health - 1) > 0:
		health -= 1
		return 
	if stage < MAX_STAGE:
		var succesor = load("res://Scenes/Enemy" + str(stage + 1) + ".tscn").instantiate()
		succesor.global_position = global_position
		get_window().get_node("Main").add_child(succesor)
	get_parent().get_parent().get_parent().queue_free()
	Score.add_score(score)
