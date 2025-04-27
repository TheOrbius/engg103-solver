extends Node2D


func _on_fracture_toughness_text_changed() -> void:
	Main.constant_edit($FractureToughness)


func _on_material_constant_text_changed() -> void:
	Main.constant_edit($MaterialConstant)


func _on_stress_text_changed() -> void:
	Main.constant_edit($Stress)


func _on_crack_length_text_changed() -> void:
	Main.constant_edit($CrackLength)


func _on_calculate_pressed() -> void:
	var tough = $FractureToughness
	var mat = $MaterialConstant
	var stress = $Stress
	var length = $CrackLength
	var disp = $SideDisplay

	Main.test_textedit(tough)
	Main.test_textedit(mat)
	Main.test_textedit(stress)
	Main.test_textedit(length)

	if tough.text and mat.text and stress.text and length.text:
		disp.text = "All fields are filled."
	
	elif mat.text and stress.text and length.text:
		disp.text = "Solving for Kc:\nKc = Y x σ x √(π x a)\nKc = %s x %s x √(π x %s)\nKc = %s" % [mat.text, stress.text, length.text, float(mat.text)*float(stress.text)*sqrt(float(length.text)*PI)]
	
	elif tough.text and stress.text and length.text:
		disp.text = "Solving for Y:\nKc = Y x σ x √(π x a)\nY = Kc/(σ x √(π x a))\nY = %s/(%s x √(π x %s))\nY = %s" % [tough.text, stress.text, length.text, float(tough.text)/(float(stress.text)*sqrt(PI*float(length.text)))]
	
	elif tough.text and mat.text and length.text:
		disp.text = "Solving for σ:\nKc = Y x σ x √(π x a)\nσ = Kc/(Y x √(π x a))\nσ = %s/(%s x √(π x %s))\nσ = %s" % [tough.text, mat.text, length.text, float(tough.text)/(float(mat.text)*sqrt(PI*float(length.text)))]
		
	elif tough.text and mat.text and stress.text:
		disp.text = "Solving for a:\nKc = Y x σ x √(π x a)\nπ x a = (Kc/(Y x σ))^2\na = ((Kc/(Y x σ))^2)/π\na = ((%s/(%s * %s)^2))\na = %s" % [tough.text, mat.text, stress.text, ((float(tough.text)/(float(mat.text)*float(stress.text)))**2)/PI]
	
	else:
		disp.text = "There is not enough information entered"
	
	
func _on_clear_pressed() -> void:
	var tough = $FractureToughness
	var mat = $MaterialConstant
	var stress = $Stress
	var length = $CrackLength
	var disp = $SideDisplay
	
	tough.text = ""
	mat.text = ""
	stress.text = ""
	length.text = ""
	disp.text = "Kc is the Fracture Toughness.
K >= Kc for fractures to occur.

Y is a material constant, commonly assumed to be 1.

Sigma is the stress limit when cracks start to propagate. Should be the same magnitude as Kc (and likewise).

a is the size of the flaw. If it is internal, it is half of the total size. a needs to be in meters. 
"
