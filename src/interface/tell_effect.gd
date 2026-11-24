extends Node2D

@export var tell: Tell

@export var suspect: Suspect

var _parts: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_parts = tell.get_body_part(suspect)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

		
