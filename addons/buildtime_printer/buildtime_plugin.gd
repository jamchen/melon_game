@tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("buildtime_printer", "res://addons/buildtime_printer/buildtime_printer.gd")

func _exit_tree():
	remove_autoload_singleton("buildtime_printer")

func _process(delta):
	if Engine.is_editor_hint():
		var t := Time.get_datetime_string_from_system()
		if ProjectSettings.get_setting("application/config/build_datetime") != t:
			ProjectSettings.set_setting("application/config/build_datetime", t)
			ProjectSettings.save()
