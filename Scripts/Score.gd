extends Node

const MAX_LEVEL: int = 3
var level: int = 1
var score: int = 0

func add_score(amount: int) -> void:
	score += amount
	if score == 9 or 12 or 15:
		if level < MAX_LEVEL:
			level += 1
