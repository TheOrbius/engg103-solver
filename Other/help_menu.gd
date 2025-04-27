extends Node2D

func _on_check_button_toggled(toggled_on: bool) -> void:
	Main.allow_text_in_notepads = toggled_on
