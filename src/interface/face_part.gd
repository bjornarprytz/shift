class_name FacePart
extends CanvasItem

var is_in_effect = false

@export var sweat_particles: CPUParticles2D

@export var head: Head

func start_tell(tell: Tell):
	print ("Start %s: %s" % [tell.effect, name])
	if (is_in_effect):
		return
	match (tell.effect):
		Tell.Effect.BLUSH:
			blush()
		Tell.Effect.TWITCH:
			twitch()
		Tell.Effect.SWEAT:
			sweat()
	is_in_effect = true

func stop_tell(tell: Tell):
	print ("Stop %s: %s" % [tell.effect, name])
	if (is_in_effect == false):
		return
	match (tell.effect):
		Tell.Effect.BLUSH:
			blush(false)
		Tell.Effect.TWITCH:
			twitch(false)
		Tell.Effect.SWEAT:
			sweat(false)
	is_in_effect = false

func blush(on:bool=true):
	var color = Color.PINK if on else Color.WHITE
	
	var tween = create_tween()
	tween.tween_property(self, "self_modulate", color, 0.5)
	await tween.finished

func sweat(on: bool=true):
	if (sweat_particles == null):
		return
	
	sweat_particles.emitting = on

func twitch(on: bool=true):
	if (name == "Eyes"):
		assert(head != null)
		head.flinch()
