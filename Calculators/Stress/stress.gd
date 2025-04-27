extends Node2D


func _on_original_length_text_changed() -> void:
	Main.constant_edit($Force)

func _on_final_length_text_changed() -> void:
	Main.constant_edit($CrossSection)

func _on_strain_text_changed() -> void:
	Main.constant_edit($Stress)

func _on_calculate_pressed() -> void:
	var force: TextEdit = $Force
	var crosssection: TextEdit = $CrossSection
	var stress: TextEdit = $Stress
	var disp: RichTextLabel = $SideDisplay
	
	Main.test_textedit(force)
	Main.test_textedit(crosssection)
	Main.test_textedit(stress)

	if force.text and crosssection.text and stress.text:
		disp.text = "All 3 fields are filled."
	elif force.text and crosssection.text:
		disp.text = "Solving for Stress:\nσ = F/AO\nσ = %s/%s\nσ = %s" % [force.text, crosssection.text, float(force.text)/float(crosssection.text)]
	elif force.text and stress.text:
		disp.text = "Solving for Crosssectional Area:\nσ = F/AO\nAO = F/σ\nA0 = %s/%s\nA0 = %s" % [force.text,stress.text, float(force.text)/float(stress.text)]
	elif crosssection.text and stress.text:
		disp.text = "Solving for Force:\nσ = F/AO\nF = σ*AO\nF = %s * %s\nF = %s" % [stress.text, crosssection.text, float(stress.text)*float(crosssection.text)]
	else:
		disp.text = "There is not enough information entered."

func _on_clear_pressed() -> void:
	var force: TextEdit = $Force
	var crosssection: TextEdit = $CrossSection
	var stress: TextEdit = $Stress
	var disp: RichTextLabel = $SideDisplay
	
	force.text = ""
	crosssection.text = ""
	stress.text = ""
	disp.text = """F should be in N
Cross Sectional Area should be in m^2
Strain should be in decimal form"""
