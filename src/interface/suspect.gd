extends Node2D

@export var suspect_name: String = ["J", "S", "D", "G", "C", "L"].pick_random()


var part: CanvasItem

func _on_control_mouse_entered() -> void:
	unnerve()

func _on_control_mouse_exited() -> void:
	renerve()

func unnerve() -> void:
	pass

func renerve() -> void:
	pass
