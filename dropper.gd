extends Node2D

@onready var cursor : Node2D = $fruit_cursor
var level := 1
const prefab := preload("res://fruit.tscn")
var original_size : Vector2
var cooldown := 0.0

func _ready():
	original_size = cursor.scale

func make_fruit():
	var fruit := prefab.instantiate()
	$"..".add_child(fruit)
	fruit.global_position = cursor.global_position
	fruit.level = level
	fruit.linear_velocity.y = 400.0
	fruit.angular_velocity = randf_range(-1, 1)
	level = randi_range(1, 5)
	cooldown = 0.2

func _process(delta):
	cooldown -= delta
	
	var t : float = 1.0 - pow(0.0001, delta)
	cursor.scale = lerp(cursor.scale, original_size * Fruit.get_target_scale(level), t)
	#cursor.global_position = get_viewport().get_mouse_position() - get_viewport().get_window().size * 0.5
	cursor.position = get_local_mouse_position()
	cursor.position.y = get_viewport_rect().position.y - get_viewport_rect().size.y * 0.4
	cursor.position.x = clamp(cursor.position.x, -188, 188)
	
	cursor.modulate = lerp(cursor.modulate, Fruit.get_color(level), t)
	
	if Input.is_key_pressed(KEY_I) and cooldown < 0.1:
		make_fruit()

func _input(event):
	if event is InputEventMouseButton:
		if event.is_released():
			if cooldown <= 0:
				make_fruit()
	elif event is InputEventKey:
		if event.keycode == KEY_ESCAPE and OS.has_feature("editor"):
			get_tree().quit()
