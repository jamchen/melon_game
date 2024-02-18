extends Label
class_name Score

var combo_counter := 1
var score := 0
var is_game_over := true

func _ready():
	text = ""

func level_start():
	$"../prev_score".text = text
	text = ""
	score = 0
	is_game_over = false

func end_combo():
	combo_counter = 1

func add(val:  int):
	if is_game_over:
		return
	combo_counter += 1
	score += int(val * combo_counter)
	write_score(score)
	
func write_score(val: int):
	text = str(int(val))

func game_over():
	if is_game_over:
		return
	is_game_over = true
	$"../prev_score".text = ""
