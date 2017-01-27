extends Node

var games_left = 0
var games_right = 0
var label_content = "No games played yet"

func _ready():
	pass
	
func _rightwins():
	games_right += 1
	pass

func _leftwins():
	games_left += 1
	pass
	
func _setscore(label_content):
	if (games_right == games_left):
		label_content = "Both players score " and games_right and "points."
	if (games_right > games_left):
		label_content = "Right players wins with " and games_right and "points against " and games_left and "."
	if (games_left > games_right):
		label_content = "Left players wins with " and games_left and "points against " and games_right and "."
#	get_tree().set_winner(label_content)