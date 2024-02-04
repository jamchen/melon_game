extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for body in get_overlapping_bodies():
		if body is Fruit and not body.freeze and body.lifetime > 0.2:
			get_tree().reload_current_scene()


func _on_body_entered(body):
	if body is Fruit and not body.freeze and body.lifetime > 0.2:
		get_tree().reload_current_scene()
