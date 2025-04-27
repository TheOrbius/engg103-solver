extends Node2D


func _on_original_area_text_changed() -> void:
	Main.constant_edit($OriginalArea)

func _on_final_area_text_changed() -> void:
	Main.constant_edit($FinalArea)

func _on_cold_work_text_changed() -> void:
	Main.constant_edit($ColdWork)


func _on_calculate_pressed() -> void:
	var original: TextEdit = $OriginalArea
	var final: TextEdit = $FinalArea
	var cold: TextEdit = $ColdWork
	var disp: RichTextLabel = $SideDisplay
	# Validate all inputs
	if original.text:
		if original.text[-1] == ".":
			original.text = original.text.left(original.text.length() - 1)
	if final.text:
		if final.text[-1] == ".":
			final.text = final.text.left(original.text.length() - 1)
	if cold.text:
		if cold.text[-1] == ".":
			cold.text = cold.text.left(original.text.length() - 1)

	# Determine which calculation needs to be done.
	if original.text and final.text and cold.text:
		disp.text = "All 3 fields are filled."
	elif original.text and final.text:
		disp.text = "Solving for Cold Work:\nCW%% = (%s-%s)/%s x 100\nCW = %s" % [original.text, final.text, original.text, str(((float(original.text)-float(final.text))/float(original.text))*100)]
	elif original.text and cold.text:
		disp.text = "Solving for Final Diameter:\n%s%% = (%s-AF)/%s x 100\nAF = - (%s x %s) + %s\nAF = %s" % [cold.text, original.text, original.text, cold.text, original.text, original.text, str(-float(original.text)*float(cold.text)/100+float(original.text))]
	elif final.text and cold.text:
		disp.text = "Solving for Original Diameter:\nCW%% = (AO-AF)/AO x 100\nCW%% x AO =  AO - AF\nCW%% x AO - AO = - AF\nAO(CW%%-1) = -AF\nAO = -AF/(CW%%-1)\nAO = -%s/(%s%%-1)\nAO = %s%%" % [final.text,cold.text, str(-float(final.text)/((float(cold.text)/100)-1))]
	else:
		disp.text = "There is not enough information entered."


func _on_clear_pressed() -> void:
	var original: TextEdit = $OriginalArea
	var final: TextEdit = $FinalArea
	var cold: TextEdit = $ColdWork
	var disp: RichTextLabel = $SideDisplay
	original.text = ""
	final.text = ""
	cold.text = ""
	disp.text = """A0 and AF should be in the same units
%CW should be the percentage
i.e 0 < CW < 100"""
