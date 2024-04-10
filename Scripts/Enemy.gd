extends Area2D

@export var speed: int = 50
@export var stage: int = 1
const MAX_STAGE: int = 3

func _physics_process(delta):
	get_parent().progress += speed * delta

func delete():
	if stage < MAX_STAGE:
		var succesor = load("res://Scenes/Enemy" + str(stage + 1) + ".tscn").instantiate()
		succesor.position = global_position
		get_window().add_child(succesor)
	get_parent().get_parent().queue_free()
