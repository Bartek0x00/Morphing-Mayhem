extends Node

signal stage_changed

const MAX_LEVEL: int = 3
var level: int = 1
var stage: int = 0
var score: int = 0

func add_score(amount: int) -> void:
	score += amount
	
