extends Node2D
class_name Dropper

onready var cursor : Node2D = $fruit_cursor
onready var score : Score = $"/root/ui/score"

var level := 1
const prefab : PackedScene = preload("res://fruit.tscn")
const original_size := Vector2(10,10)
var cooldown := 0.0
const border_const := 200

var is_game_over : bool = false
var ending_over : bool = false
var ending_cooldown : float = 0.0

var fruit_rng := RandomNumberGenerator.new()

func _ready():
	fruit_rng.set_seed(4) # Chosen with a fair dice roll (also the sequence starts with two small fruits)
	score.level_start()

func make_fruit():
	if is_game_over:
		if ending_over:
			get_tree().reload_current_scene()
		return
	
	score.end_combo()
	var fruit = prefab.instance()
	fruit.level = level
	$"..".add_child(fruit)
	fruit.global_position.y = cursor.global_position.y
	var border_dist := border_const - Fruit.get_target_scale(level) * original_size.x
	fruit.global_position.x = clamp(cursor.global_position.x, -border_dist, border_dist)
	fruit.linear_velocity.y = 400.0
	fruit.linear_velocity.x = 0
	fruit.angular_velocity = fruit_rng.randf() * 0.2 - 0.1
	level = fruit_rng.randi() % 5 + 1
	cooldown = 0.1 + min(0.2, level * 0.1)

func _physics_process(delta: float):
	if is_game_over:
		do_ending(delta)

	cooldown -= delta
	
	if not is_game_over:
		var t : float = 1.0 - pow(0.0001, delta)
		var target_scale := original_size * Fruit.get_target_scale(level)
		cursor.scale = lerp(cursor.scale, target_scale, t)
		var border_dist := border_const - cursor.scale.x
		cursor.position.x = clamp(get_local_mouse_position().x, -border_dist, border_dist)
		
		cursor.modulate = lerp(cursor.modulate, Fruit.get_color(level), t)
	
	if Input.is_key_pressed(KEY_I) and cooldown < 0.13:
		make_fruit()

func _input(event):
	if event is InputEventMouseButton:
		if not event.is_pressed():
			if cooldown <= 0:
				make_fruit()
	elif event is InputEventKey:
		if event.physical_scancode == KEY_ESCAPE and OS.has_feature("editor"):
			get_tree().quit()

func game_over():
	if is_game_over:
		return
	is_game_over = true
	ending_over = false
	ending_cooldown = 1.0
	score.game_over()

	var parent : Node2D = $".."
	for c in parent.get_children():
		if c is Fruit:
			c.game_over = true
		

func do_ending(delta: float):
	ending_cooldown -= delta
	if ending_cooldown > 0.0 or ending_over:
		return
	ending_cooldown += fruit_rng.randf() * 0.3 + 0.03
	var parent : Node2D = $".."
	for c in parent.get_children():
		if c is Fruit and not c.popped:
			c.pop()
			return
	ending_over = true
