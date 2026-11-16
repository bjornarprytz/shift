class_name Tell
extends Resource

enum Part {
	EARS,
	NOSE,
	FACE,
	EYES,
	CHEEKS,
	BREATHING,
	MOUTH
}

enum Effect {
	BLUSH,
	TWITCH,
	SWEAT
}

@export var part: Part
@export var effect: Effect
