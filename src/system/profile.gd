class_name Profile
extends Resource

@export var suspect_name: String

@export var appearance: Appearance

@export var tells: Array[Tell]

## Replace string[key] with string[val]
@export var speech_impediment: Dictionary[String, String] = {}
