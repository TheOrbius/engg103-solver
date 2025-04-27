class_name Main extends Node2D

var help_target_position: Vector2 = Vector2(0,800)

var offset: float = 0

var d: float = 1440

static var allow_text_in_notepads: bool = false


@onready var panels: Array[Node2D] = [$Panel0, $Panel1, $Panel2]

func _ready() -> void:
	$HelpMenu.find_child("CloseButton").connect("pressed", close_help_menu)
	
func _process(delta: float) -> void:
	$HelpMenu.position = $HelpMenu.position.lerp(help_target_position, delta*8)
	if offset:
		var new = lerpf(offset, 0, delta*12)
		var gap = new-offset
		offset = new
		for panel in panels:
			panel.position.x += gap
			panel.position.x = wrapf(panel.position.x, -d*2, d)
		if abs(offset) < 1:
			offset = 0
			for panel in panels:
				panel.position.x = snapped(panel.position.x, 1440)
				
		
func open_help_menu():
	help_target_position = Vector2(0,0)

func close_help_menu():
	help_target_position = Vector2(0,800)

func shift_left():
	offset -= d

func shift_right():
	offset += d



	
static func test_textedit(tested: TextEdit):
	if tested.text:
		if tested.text[-1] == ".":
			tested.text = tested.text.left(tested.text.length() - 1)

static func safe_test_textedit(tested: TextEdit):
	var real_text = ""
	if tested.text:
		if tested.text[-1] == ".":
			real_text = tested.text.left(tested.text.length() - 1)
		else:
			real_text = tested.text
	if len(real_text) >= 2:
		if real_text[-2] == "." and real_text[-1] == "0":
			real_text = real_text.left(real_text.length() - 2)
	return real_text

static func constant_edit(tested: TextEdit):
	var box: TextEdit = tested
	var acceptable_characters: Array[String] = ["0","1","2","3","4","5","6","7","8","9","."]
	var newtext: String = ""
	var dot: bool = false
	var cur = box.get_caret_column()
	for letter in box.text:
		if letter in acceptable_characters:
			if letter == ".":
				if !dot:
					newtext += letter
					dot = true
			else:
				newtext += letter
	box.text = newtext
	box.set_caret_column(cur)


func _on_text_edit_text_changed() -> void:
	if !allow_text_in_notepads:
		constant_edit($TextEdit)


func _on_text_edit_2_text_changed() -> void:
	if !allow_text_in_notepads:
		constant_edit($TextEdit2)

func _on_text_edit_3_text_changed() -> void:
	if !allow_text_in_notepads:
		constant_edit($TextEdit3)

func _on_text_edit_4_text_changed() -> void:
	if !allow_text_in_notepads:
		constant_edit($TextEdit4)

func _on_text_edit_5_text_changed() -> void:
	if !allow_text_in_notepads:
		constant_edit($TextEdit5)

func _on_text_edit_6_text_changed() -> void:
	if !allow_text_in_notepads:
		constant_edit($TextEdit6)
