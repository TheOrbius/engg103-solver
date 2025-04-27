extends Node2D


func _on_original_length_text_changed() -> void:
	Main.constant_edit($OriginalLength)

func _on_final_length_text_changed() -> void:
	Main.constant_edit($FinalLength)

func _on_strain_text_changed() -> void:
	Main.constant_edit($Strain)


func _on_calculate_pressed() -> void:
	var original: TextEdit = $OriginalLength
	var final: TextEdit = $FinalLength
	var strain: TextEdit = $Strain
	var disp: RichTextLabel = $SideDisplay
	# Validate all inputs
	Main.test_textedit($OriginalLength)
	Main.test_textedit($FinalLength)
	Main.test_textedit($Strain)
			
	# Determine which calculation needs to be done.
	if original.text and final.text and strain.text:
		disp.text = "All 3 fields are filled."
	elif original.text and final.text:
		disp.text = "Solving for Strain:\nε = (Lf-L0)/L0\nε = (%s-%s)/%s\nε = %s" % [final.text, original.text, original.text, str((float(final.text)-float(original.text))/float(original.text))]
	elif original.text and strain.text:
		disp.text = "Solving for Final Length:\nε = (Lf-L0)/L0\nL0 * ε = Lf-L0\nLf = L0 * ε + L0\nLf = %s * %s + %s\nLf = %s" % [original.text, strain.text, original.text, float(original.text)*float(strain.text)+float(original.text)]
	elif final.text and strain.text:
		disp.text = "Solving for Original Length:\nε = (Lf-L0)/L0\nL0 * ε = Lf-L0\nL0 * ε + L0 = Lf\nL0(ε+1) = Lf\nL0 = Lf/(ε+1)\nL0 = %s/(%s+1)\nL0 = %s" % [final.text,strain.text, float(final.text)/(float(strain.text)+1)]
	else:
		disp.text = "There is not enough information entered."

func _on_clear_pressed() -> void:
	var original: TextEdit = $OriginalLength
	var final: TextEdit = $FinalLength
	var strain: TextEdit = $Strain
	var disp: RichTextLabel = $SideDisplay
	original.text = ""
	final.text = ""
	strain.text = ""
	disp.text = """L0 and Lf should be in the same units
Strain should be in decimal, not percent.
i.e 0.4, not 40"""
