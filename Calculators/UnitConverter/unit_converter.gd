extends Node2D

var global_edit_id: int = 0

var l_index: int = 0
var r_index: int = 0

var base_modifier: Array[float] = [1000000.0, 10000.0, 1.0, 0.000001]


func _ready() -> void:
	var menu = $TypeSelector.get_popup()
	menu.connect("id_pressed", change_type, 0)
	
	var lu = $LeftUnits.get_popup()
	lu.connect("id_pressed", l_update_units, 0)
	
	var ru = $RightUnits.get_popup()
	ru.connect("id_pressed", r_update_units, 0)
	
	change_type(0)

func _on_input_left_text_changed() -> void:
	Main.constant_edit($InputLeft)
	update_other($InputLeft, $InputRight, true)


func _on_input_right_text_changed() -> void:
	Main.constant_edit($InputRight)
	update_other($InputRight, $InputLeft, false)

func update_other(converter: TextEdit, converted: TextEdit, left_prim: bool) -> void:
	var real_text = Main.safe_test_textedit(converter)
	converted.text = real_text
	
	var difference = (base_modifier[l_index])/(base_modifier[r_index])
	if left_prim:
		difference = (base_modifier[r_index])/(base_modifier[l_index])

	converted.text = str(float(real_text)*difference)

func change_type(id: int):
	global_edit_id = id
	match id:
		0:
			$TypeSelector.text = "Area"
			var lpop: PopupMenu = $LeftUnits.get_popup()
			var rpop: PopupMenu = $RightUnits.get_popup()
			base_modifier.clear()
			lpop.clear(true)
			rpop.clear(true)
			
			lpop.add_item("mm^2")
			lpop.add_item("cm^2")
			lpop.add_item("m^2")
			lpop.add_item("km^2")
			
			rpop.add_item("mm^2")
			rpop.add_item("cm^2")
			rpop.add_item("m^2")
			rpop.add_item("km^2")
			
			base_modifier = [1000000.0, 10000.0, 1.0, 0.000001]
		1:
			$TypeSelector.text = "Length"
			var lpop: PopupMenu = $LeftUnits.get_popup()
			var rpop: PopupMenu = $RightUnits.get_popup()
			lpop.clear(true)
			rpop.clear(true)
			
			lpop.add_item("mm")
			lpop.add_item("cm")
			lpop.add_item("m")
			lpop.add_item("km")
			
			rpop.add_item("mm")
			rpop.add_item("cm")
			rpop.add_item("m")
			rpop.add_item("km")
			
			base_modifier = [1000.0, 100.0, 1.0, 0.001]
		2:
			$TypeSelector.text = "Force"
			var lpop: PopupMenu = $LeftUnits.get_popup()
			var rpop: PopupMenu = $RightUnits.get_popup()
			lpop.clear(true)
			rpop.clear(true)
			
			lpop.add_item("N")
			lpop.add_item("kN")
			lpop.add_item("lbf")
			
			rpop.add_item("N")
			rpop.add_item("kN")
			rpop.add_item("lbf")
			
			base_modifier = [1.0, 0.001, 0.224809]
		3:
			$TypeSelector.text = "Pressure"
			var lpop: PopupMenu = $LeftUnits.get_popup()
			var rpop: PopupMenu = $RightUnits.get_popup()
			lpop.clear(true)
			rpop.clear(true)
			
			lpop.add_item("Pa")
			lpop.add_item("MPa")
			lpop.add_item("GPa")
			lpop.add_item("PSI")
			
			rpop.add_item("Pa")
			rpop.add_item("MPa")
			rpop.add_item("GPa")
			rpop.add_item("PSI")
			
			base_modifier = [1.0, 0.000001, 0.000000001, 0.000145038]
		4:
			$TypeSelector.text = "Mass"
			var lpop: PopupMenu = $LeftUnits.get_popup()
			var rpop: PopupMenu = $RightUnits.get_popup()
			lpop.clear(true)
			rpop.clear(true)
			
			lpop.add_item("Kg")
			lpop.add_item("g")
			lpop.add_item("mg")
			
			rpop.add_item("Kg")
			rpop.add_item("g")
			rpop.add_item("mg")
			
			base_modifier = [0.001, 1, 1000.0]
		5:
			$TypeSelector.text = "Volume"
			var lpop: PopupMenu = $LeftUnits.get_popup()
			var rpop: PopupMenu = $RightUnits.get_popup()
			lpop.clear(true)
			rpop.clear(true)
			
			lpop.add_item("mm^3")
			lpop.add_item("cm^3")
			lpop.add_item("m^3")
			lpop.add_item("km^3")
			
			rpop.add_item("mm^3")
			rpop.add_item("cm^3")
			rpop.add_item("m^3")
			rpop.add_item("km^3")
			
			base_modifier = [1000000000.0, 1000000.0, 1.0, 0.000000001]
		_:
			# Should not happen
			pass
	l_update_units(0)
	r_update_units(0)
	
func l_update_units(id):
	l_index = id
	$LeftUnits.text = $LeftUnits.get_popup().get_item_text(id)
	
	update_other($InputRight, $InputLeft, false)

func r_update_units(id):
	r_index = id
	$RightUnits.text = $RightUnits.get_popup().get_item_text(id)
	
	update_other($InputLeft, $InputRight, true)
