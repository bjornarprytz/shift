class_name Profile
extends Resource

@export var suspect_name: String
@export var hair_color: Color
@export var skin_color: Color
@export var eye_color: Color
@export var height: float

@export var tells: Array[Tell] = []

## Replace string[key] with string[val]
@export var speech_impediment: Dictionary[String, String] = {}
