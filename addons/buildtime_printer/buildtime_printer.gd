extends Node

func _ready():
	print("Build time: ", ProjectSettings.get_setting("application/config/build_datetime"))
