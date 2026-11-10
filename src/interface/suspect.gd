extends Node2D

@export var suspect_name: String = ["J", "S", "D", "G", "C", "L"].pick_random()

@onready var eye_r: Eye = %EyeR
@onready var eye_l: Eye = %EyeL

@onready var nose: FacePart = %Nose
@onready var mouth: FacePart = %Mouth
@onready var ear_r: FacePart = %EarR
@onready var ear_l: FacePart = %EarL

var part: CanvasItem

func _process(delta: float) -> void:
	eye_r.focal_point = get_global_mouse_position()
	eye_l.focal_point = get_global_mouse_position()

func _on_control_mouse_entered() -> void:
	unnerve()

func _on_control_mouse_exited() -> void:
	renerve()

func unnerve() -> void:
	var part_list = [[nose], [mouth], [ear_r, ear_l]]

	var part_group = part_list.pick_random()
	for part in part_group:
		var f = ["blush", "whiten", "twitch"].pick_random()
		await part.call(f)

func renerve() -> void:
	pass
