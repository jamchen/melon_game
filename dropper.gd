extends Node2D

@onready var cursor : Node2D = $fruit_cursor
var level := 1
const prefab := preload("res://fruit.tscn")
var original_size : Vector2

func _ready():
	original_size = cursor.scale

func make_fruit():
	var fruit := prefab.instantiate()
	$"..".add_child(fruit)
	fruit.global_position = cursor.global_position
	fruit.level = level
	level = randi_range(1, 5)

func _process(delta):
	var t : float = 1.0 - pow(0.0001, delta)
	cursor.scale = lerp(cursor.scale, original_size * Fruit.get_target_scale(level), t)
	#cursor.global_position = get_viewport().get_mouse_position() - get_viewport().get_window().size * 0.5
	cursor.position = get_local_mouse_position()
	cursor.position.y = get_viewport_rect().position.y - get_viewport_rect().size.y * 0.4
	
	cursor.modulate = lerp(cursor.modulate, Fruit.get_color(level), t)
	
	if Input.is_key_pressed(KEY_I):
		make_fruit()

func _input(event):
	if event is InputEventMouseButton:
		if event.is_released():
			make_fruit()
	elif event is InputEventKey:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()
