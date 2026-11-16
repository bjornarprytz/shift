extends Node2D

@onready var suspects: Node2D = $Suspects
@onready var lineup_pos: Node2D = $LineupPos

func _get_suspects() -> Array[Suspect]:
	var s: Array[Suspect] = []
	
	for c in suspects.get_children():
		assert(c is Suspect)
		s.push_back(c)
	return s

func _get_lineup_pos() -> Array[Node2D]:
	var p: Array[Node2D] = []
	
	for c in lineup_pos.get_children():
		p.push_back(c)
	return p

func _ready() -> void:
	var pos = _get_lineup_pos()
	var sus = _get_suspects()
	
	for s in sus:
		var p = pos.pop_front()
		s.walk_to(p.global_position)

func _on_left_button_pressed() -> void:
	print("Pressed left button")

func _on_right_button_pressed() -> void:
	print("Pressed right button")

func _on_button_mouse_entered(source: Control) -> void:
	print("Hovering button %s" % [source])

func _on_line_edit_text_submitted(new_text: String) -> void:
	for c in _get_suspects():
		c.say(new_text)
