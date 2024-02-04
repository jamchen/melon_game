extends Node2D

@onready var cursor : Node2D = $fruit_cursor
var level := 1
const prefab := preload("res://fruit.tscn")
var original_size : Vector2
var cooldown := 0.0
const border_const := 203

func _ready():
	original_size = cursor.scale

func make_fruit():
	var fruit := prefab.instantiate()
	$"..".add_child(fruit)
	fruit.global_position = cursor.global_position
	var border_dist := border_const - Fruit.get_target_scale(level) * 0.5 * original_size.x
	fruit.global_position.x = clamp(fruit.global_position.x, -border_dist, border_dist)
	fruit.level = level
	fruit.linear_velocity.y = 400.0
	fruit.angular_velocity = randf_range(-1, 1)
	level = randi_range(1, 5)
	cooldown = 0.1 + min(0.2, fruit.level * 0.1)

func _process(delta):
	cooldown -= delta
	
	var t : float = 1.0 - pow(0.0001, delta)
	var target_scale := original_size * Fruit.get_target_scale(level)
	cursor.scale = lerp(cursor.scale, target_scale, t)
	var border_dist := border_const - cursor.scale.x * 0.5
	cursor.position.x = clamp(get_local_mouse_position().x, -border_dist, border_dist)
	
	cursor.modulate = lerp(cursor.modulate, Fruit.get_color(level), t)
	
	if Input.is_key_pressed(KEY_I) and cooldown < 0.13:
		make_fruit()

func _input(event):
	if event is InputEventMouseButton:
		if event.is_released():
			if cooldown <= 0:
				make_fruit()
	elif event is InputEventKey:
		if event.keycode == KEY_ESCAPE and OS.has_feature("editor"):
			get_tree().quit()
