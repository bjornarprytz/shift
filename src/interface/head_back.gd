class_name HeadBack
extends Node2D

@onready var head: Sprite2D = %Head
@onready var hair: Sprite2D = %Hair
@onready var ear_l: Sprite2D = %EarL
@onready var ear_r: Sprite2D = %EarR

@onready var bare_skin = [head, ear_l, ear_r]

func apply_appearance(appearance: Appearance):
	hair.texture = appearance.hair_style_back
	ear_l.texture = appearance.ear
	ear_r.texture = appearance.ear
	hair.modulate = appearance.hair_color
	
	for s in bare_skin:
		s.modulate = appearance.skin_color
