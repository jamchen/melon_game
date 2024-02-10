extends Node2D

onready var cursor : Node2D = $fruit_cursor
onready var score : Score = $"../ui/score"

var level := 1
const prefab : PackedScene = preload("res://fruit.tscn")
const original_size := Vector2(10,10)
var cooldown := 0.0
const border_const := 201

func _ready():
	score.level_start()

func make_fruit():
	score.end_combo()
	var fruit = prefab.instance()
	fruit.level = level
	$"..".add_child(fruit)
	fruit.global_position.y = cursor.global_position.y
	var border_dist := border_const - Fruit.get_target_scale(level) * original_size.x
	fruit.global_position.x = clamp(cursor.global_position.x, -border_dist, border_dist)
	fruit.linear_velocity.y = 400.0
	fruit.angular_velocity = rand_range(-1, 1)
	level = randi() % 5 + 1
	cooldown = 0.1 + min(0.2, fruit.level * 0.1)

func _process(delta):
	cooldown -= delta
	
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
