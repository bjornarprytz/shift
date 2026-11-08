extends Node2D

@export var suspect_name: String = ["J", "S", "D", "G", "C", "L"].pick_random()

@onready var eye_r: Eye = %EyeR
@onready var eye_l: Eye = %EyeL

var part: CanvasItem

func _process(delta: float) -> void:
	eye_r.focal_point = get_global_mouse_position()
	eye_l.focal_point = get_global_mouse_position()

func _on_control_mouse_entered() -> void:
	unnerve()

func _on_control_mouse_exited() -> void:
	renerve()

func unnerve() -> void:
	pass

func renerve() -> void:
	pass
