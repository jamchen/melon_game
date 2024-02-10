extends Area2D

onready var dropper : Dropper = $"/root/Node2D/dropper"
var restart_queued := false

func _process(_delta):
	if restart_queued:
		dropper.game_over()
		return

	for body in get_overlapping_bodies():
		if body is Fruit and body.in_game:
			dropper.game_over()

func _on_body_entered(body):
	if body is Fruit and body.in_game:
		restart_queued = true
