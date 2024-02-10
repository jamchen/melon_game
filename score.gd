extends Label
class_name Score

var combo_counter := 1
var score := 0

func _ready():
	text = ""

func level_start():
	$"../prev_score".text = text
	text = ""
	score = 0
	seed(4) # Chosen with a fair dice roll (also the sequence starts with two small fruits)

func end_combo():
	combo_counter = 1

func add(val:  int):
	combo_counter += 1
	score += int(val * combo_counter)
	write_score(score)
	
func write_score(val: int):
	text = str(int(val))
