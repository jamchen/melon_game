extends Area2D

var restart_queued := false

func _process(_delta):
	if restart_queued:
		get_tree().reload_current_scene()
		return

	for body in get_overlapping_bodies():
		if body is Fruit and not body.freeze and body.in_game:
			get_tree().reload_current_scene()

func _on_body_entered(body):
	if body is Fruit and body.in_game:
		restart_queued = true
