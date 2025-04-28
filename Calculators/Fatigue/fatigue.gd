extends Node2D



func _on_max_stress_text_changed() -> void:
	Main.constant_edit($MaxStress)

func _on_min_stress_text_changed() -> void:
	Main.constant_edit($MinStress)



func _on_calculate_button_pressed() -> void:
	var max = $MaxStress
	var min = $MinStress
	var disp = $SideDisplay
	
	Main.test_textedit(max)
	Main.test_textedit(min)
	
	if max.text and min.text:
		disp.text = "Solving for Δσ:
Δσ = σ_max - σ_min
Δσ = %s - %s
Δσ = %s

Solving for Alternating Stress:
σa = Δσ/2
σa = %s/2
σa = %s

Solving for Average / Mean:
σm = (σ_max + σ_min)/2
σm = (%s + %s)/2
σm = %s

Solving for R:
R = σ_max/σ_min
R = %s/%s
R = %s
" % [max.text,min.text,float(max.text)-float(min.text), float(max.text)-float(min.text), (float(max.text)-float(min.text))/2,
max.text, min.text, (float(max.text)+float(min.text))/2,
max.text,min.text, float(max.text)/float(min.text)
]


	else:
		disp.text = "There is not enough information entered."


func _on_clear_button_pressed() -> void:
	var max = $MaxStress
	var min = $MinStress
	var disp = $SideDisplay
	
	max.text = ""
	min.text = ""
	disp.text = "The units will be the same as the ones entered. Both need to use the same magnitudes.

σ_max is the highest amount of stress in a stress cycle

σ_min is the lowest amount of stress in a stress cycle"
