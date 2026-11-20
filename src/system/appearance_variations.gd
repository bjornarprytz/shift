class_name AppearanceVariations
extends Resource

@export var eyebrows: Array[Texture2D] = []
@export var hair_styles_front: Array[Texture2D] = []
@export var hair_styles_back: Array[Texture2D] = []
@export var ears: Array[Texture2D] = []
@export var noses: Array[Texture2D] = []

@export var skin_colors: Array[Color] = []
@export var eye_colors: Array[Color] = []
@export var hair_colors: Array[Color] = []

func create_random_appearance() -> Appearance:
	var a = Appearance.new()
	a.eyebrows = eyebrows.pick_random()
	a.ear = ears.pick_random()
	var hairIndex = randi_range(0, hair_styles_front.size()-1)
	a.hair_style_front = hair_styles_front[hairIndex]
	a.hair_style_back = hair_styles_back[hairIndex]
	a.nose = noses.pick_random()
	a.height_variation = randf_range(-10.0, 10.0)
	
	a.hair_color = hair_colors.pick_random()
	a.eye_color = eye_colors.pick_random()
	a.skin_color = skin_colors.pick_random()
	
	return a
	
