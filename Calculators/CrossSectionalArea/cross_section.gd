extends Node2D

var find_radius = false

func _on_input_text_changed() -> void:
	Main.constant_edit($Input)


func _on_type_toggle_toggled(toggled_on: bool) -> void:
	var box: TextEdit = $Input
	find_radius = toggled_on
	if find_radius:
		box.placeholder_text = "Radius"
	else:
		box.placeholder_text = "Diameter"
	_on_calculate_pressed(true)


func _on_calculate_pressed(t = false) -> void:
	var disp: RichTextLabel = $SideDisplay
	var input: TextEdit = $Input
	if input.text:
		if input.text[-1] == ".":
			input.text = input.text.left(input.text.length() - 1)
		if find_radius:
			disp.text = "From Radius:\nA = Pi * r^2\nA = Pi * %s^2\nA = %s" % [input.text, PI*float(input.text)**2]
		else:
			disp.text = "From Diameter:\nA = Pi * (d/2)^2\nA = Pi * (%s/2)^2\nA = %s" % [input.text, PI*(float(input.text)/2)**2]
	else:
		if !t:
			disp.text = "Nothing has been entered."

func _on_clear_pressed() -> void:
	var input: TextEdit = $Input
	var disp: RichTextLabel = $SideDisplay
	input.text = ""
	disp.text = """Ensure that the correct
Diameter / Radius is
selected.

Keep track of your units."""
