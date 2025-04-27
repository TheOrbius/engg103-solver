extends Node2D


func _on_stress_text_changed() -> void:
	Main.constant_edit($Stress)


func _on_modulus_text_changed() -> void:
	Main.constant_edit($Modulus)

func _on_strain_text_changed() -> void:
	Main.constant_edit($Strain)

func _on_calculate_pressed() -> void:
	var stress = $Stress
	var mod = $Modulus
	var strain = $Strain
	var disp = $Display
	
	Main.test_textedit(stress)
	Main.test_textedit(mod)
	Main.test_textedit(strain)
	
	if stress.text and mod.text and strain.text:
		disp.text = "All 3 fields are filled."
	elif stress.text and mod.text:
		disp.text = "Solving for strain:\nσ = Eε\nε = σ/E\nε = %s / %s\nε = %s" % [stress.text, mod.text, float(stress.text)/float(mod.text)]
	elif stress.text and strain.text:
		disp.text = "Solving for Young's Modulus:\nσ = Eε\nE = σ/ε\nE = %s / %s\nE = %s" % [stress.text, strain.text, float(stress.text)/float(strain.text)]
	elif mod.text and strain.text:
		disp.text = "Solving for stress:\nσ = Eε\nσ = %s * %s\nσ = %s" % [mod.text, strain.text, float(mod.text)*float(strain.text)]
	else:
		disp.text = "There is not enough information entered."

func _on_clear_pressed() -> void:
	var stress = $Stress
	var mod = $Modulus
	var strain = $Strain
	var disp = $Display
	
	stress.text = ""
	mod.text = ""
	strain.text = ""
	disp.text = """Stress and Modulus should be in the same units

Strain should be in decimal form, not percentage."""
