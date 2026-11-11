extends Node2D

@onready var character: Suspect = $Character
@onready var character_2: Suspect = $Character2
@onready var character_3: Suspect = $Character3
@onready var character_4: Suspect = $Character4

@onready var suspect_pos: Node2D = $SuspectPos
@onready var suspect_pos_2: Node2D = $SuspectPos2
@onready var suspect_pos_3: Node2D = $SuspectPos3
@onready var suspect_pos_4: Node2D = $SuspectPos4

func _ready() -> void:
	character.walk_to(suspect_pos.global_position)
	character_2.walk_to(suspect_pos_2.global_position)
	character_3.walk_to(suspect_pos_3.global_position)
	character_4.walk_to(suspect_pos_4.global_position)

func _on_left_button_pressed() -> void:
	print("Pressed left button")

func _on_right_button_pressed() -> void:
	print("Pressed right button")

func _on_button_mouse_entered(source: Control) -> void:
	print("Hovering button %s" % [source])
