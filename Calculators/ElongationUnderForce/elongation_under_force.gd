extends Node2D



func _on_initial_area_text_changed() -> void:
	Main.constant_edit($InitialArea)

func _on_initial_length_text_changed() -> void:
	Main.constant_edit($InitialLength)

func _on_force_text_changed() -> void:
	Main.constant_edit($Force)

func _on_modulus_text_changed() -> void:
	Main.constant_edit($Modulus)

func _on_yield_stress_text_changed() -> void:
	Main.constant_edit($YieldStress)

func _on_calculate_pressed() -> void:
	var area = $InitialArea
	var initlength = $InitialLength
	var force = $Force
	var modulus = $Modulus
	
	var disp = $SideDisplay
	
	Main.test_textedit(area)
	Main.test_textedit(initlength)
	Main.test_textedit(force)
	Main.test_textedit(modulus)


	
	if area.text and initlength.text and force.text and modulus.text:
		disp.text = "First, calculating the stress:
σ = F/A
σ = %s/%s
σ = %s

Calculating strain from Hooke's Law:
ε = σ/E
ε = %s/%s
ε = %s

Calculating final length from strain:
Lf = L0 * ε + L0
Lf = %s * %s + %s
Lf = %s" % [force.text, area.text, (float(force.text)/float(area.text)), (float(force.text)/float(area.text)), modulus.text, (float(force.text)/float(area.text))/float(modulus.text), initlength.text, (float(force.text)/float(area.text))/float(modulus.text), initlength.text, float(initlength.text)*(float(force.text)/float(area.text))/float(modulus.text) + float(initlength.text)]
		
	else:
		disp.text = "All fields need to be entered."

func _on_clear_pressed() -> void:
	var area = $InitialArea
	var initlength = $InitialLength
	var force = $Force
	var modulus = $Modulus
	
	var disp = $SideDisplay
	
	area.text = ""
	initlength.text = ""
	force.text = ""
	modulus.text = ""
	
	disp.text = "Initial Area and Initial Length need to be in the same units, e.g mm^2 and mm respectively. The final answer will be given in the same units.

Force needs to be in N

Modulus needs to be in MPa"
