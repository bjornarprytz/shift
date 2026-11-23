extends Node2D

@onready var suspect_factory = preload("res://interface/suspect.tscn")
@onready var spotlight: PointLight2D = %Spotlight

@export var suspect_count: int = 7
@export var character_variations: AppearanceVariations

@onready var suspects: Node2D = %Suspects
@onready var lineup_pos: Node2D = $LineupPos
@onready var detective: Suspect = %Detective
@onready var detective_back: SuspectBack = %DetectiveBack

@onready var detective_target_pos: Node2D = %Detective_target_pos
@onready var detective_back_target_pos: Node2D = %DetectiveBack_target_pos

func _process(delta: float) -> void:
	spotlight.global_position = get_global_mouse_position()

func _load_suspects() -> Array[Suspect]:
	var s: Array[Suspect] = []
	var i = 0
	for c in range(suspect_count):
		var new_sus = suspect_factory.instantiate() as Suspect
		suspects.add_child(new_sus)
		new_sus.position = (Vector2.LEFT * 700) + (Vector2.LEFT * 150.0 * i) + (Vector2.DOWN * 500.0)
		new_sus.apply_appearance(character_variations.create_random_appearance())
		s.push_back(new_sus)
		i += 1
	
	return s

func _get_suspects() -> Array[Suspect]:
	var s: Array[Suspect] = []
	for c in suspects.get_children():
		assert (c is Suspect)
		s.push_back(c)
	return s

func _get_lineup_pos() -> Array[Node2D]:
	var p: Array[Node2D] = []
	
	for c in lineup_pos.get_children():
		p.push_back(c)
	return p

func _ready() -> void:
	_load_suspects()
	

func _on_left_button_pressed() -> void:
	print("Pressed left button")

func _on_right_button_pressed() -> void:
	print("Pressed right button")

func _on_button_mouse_entered(source: Control) -> void:
	print("Hovering button %s" % [source])

func _on_line_edit_text_submitted(new_text: String) -> void:
	for c in _get_suspects():
		c.say(new_text)

func _on_character_creation_appearance_selected(appearance: Appearance) -> void:
	detective.apply_appearance(appearance)
	detective_back.apply_appearance(appearance)
	_action_scene()

func _suspects_enter():
	var pos = _get_lineup_pos()
	var sus = _get_suspects()
	
	for s in sus:
		var p = pos.pop_front()
		s.walk_to(p.global_position)

func _action_scene():
	detective.walk_to(detective_target_pos.global_position,0.0)
	detective_back.walk_to(detective_back_target_pos.global_position)
	
	_suspects_enter()
	
	
