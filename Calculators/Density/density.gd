extends Node2D



func _on_density_text_changed() -> void:
	Main.constant_edit($Density)


func _on_mass_text_changed() -> void:
	Main.constant_edit($Mass)

func _on_volume_text_changed() -> void:
	Main.constant_edit($Volume)
	


func _on_calculate_pressed() -> void:
	var density = $Density
	var mass = $Mass
	var volume = $Volume
	var disp = $DisplayText
	
	Main.test_textedit(density)
	Main.test_textedit(mass)
	Main.test_textedit(volume)
	
	if density.text and mass.text and volume.text:
		disp.text = "All fields are full."
	elif mass.text and volume.text:
		disp.text = "Sovling for Density:\nP = m/V\nP = %s/%s\nP=%s" % [mass.text, volume.text, float(mass.text)/float(volume.text)]
	elif density.text and volume.text:
		disp.text = "Solving for Mass:\nP = m/V\nm = Px V\nM = %s x %s\nM = %s" % [density.text, volume.text, float(density.text)*float(volume.text)]
	elif density.text and mass.text:
		disp.text = "Sovling for Volume:\nP = m/V\nV = m/P\nV = %s/%s\nV = %s" % [mass.text,density.text, float(mass.text)/float(density.text)]
	else:
		disp.text = "Not enough information entered."
func _on_clear_pressed() -> void:
	var density = $Density
	var mass = $Mass
	var volume = $Volume
	var disp = $DisplayText
	
	density.text = ""
	mass.text = ""
	volume.text = ""
	disp.text = "P is density, units in m/V

m is Mass

V is Volume"
