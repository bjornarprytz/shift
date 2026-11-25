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

func get_body_parts(sus: Suspect) -> Array:
	match (part):
		Part.EARS:
			return [sus.head.ear_l, sus.head.ear_r]
		Part.NOSE:
			return [sus.head.nose]
		Part.FACE:
			return [sus.head.head]
		Part.EYES:
			return [sus.head.eyes]
		Part.CHEEKS:
			return [sus.head.cheeks]
		Part.BREATHING:
			return [] # [sus.body.torso]
		Part.MOUTH:
			return [sus.head.mouth]
		
	return []


static func random(p: Part=-1) -> Tell:
	var t = Tell.new()
	if (p == -1):
		p = Part.values().pick_random()
	
	t.part = p	
	t.effect = _possible_effect(p).pick_random()
	
	return t

static func random_set(count: int) -> Array[Tell]:
	var parts = Part.values()
	assert (count > 0 and count <= parts.size())
	parts.shuffle()
	var r: Array[Tell] = []
	
	
	for p in parts:
		r.push_back(Tell.random(p))
		count -= 1
		if count == 0:
			break
	
	return r


static func _possible_effect(p: Part) -> Array[Effect]:
	match(p):
		Part.EARS:
			return Effect.values()
		Part.NOSE:
			return Effect.values()
		Part.FACE:
			return [Effect.BLUSH, Effect.SWEAT]
		Part.EYES:
			return [Effect.SWEAT, Effect.TWITCH]
		Part.CHEEKS:
			return [Effect.BLUSH]
		Part.BREATHING:
			return [Effect.TWITCH, Effect.SWEAT]
		Part.MOUTH:
			return [Effect.TWITCH]	
	return []
