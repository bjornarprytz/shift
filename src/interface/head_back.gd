extends Node2D

@onready var head: Sprite2D = %Head
@onready var hair: Sprite2D = %Hair

func apply_apperance(appearance: Appearance):
	head.modulate = appearance.skin_color
	hair.modulate = appearance.hair_color
