class_name Body
extends Node2D

@onready var bare_skin = [%Neck, %HandL, %HandR]

@onready var torso: ColorRect = %Torso

var breath_tween: Tween

func apply_appearance(appearance: Appearance):
	for s in bare_skin:
		s.modulate = appearance.skin_color

func set_breath(speed: float, magnitude: float, interval: float, irregularity: float=0.0):
	assert (speed > 0.0 and magnitude > 0.0 and irregularity >= 0.0)
	if (breath_tween != null):
		await breath_tween.loop_finished
	breath_tween = create_tween().set_loops()
	
	breath_tween.tween_property(torso, "position:y", magnitude, speed).as_relative()
	breath_tween.set_parallel()
	breath_tween.tween_property(torso, "size:y", -magnitude, speed).as_relative()

	breath_tween.set_parallel(false)
	breath_tween.tween_interval(interval + randf_range(0.0, irregularity))
	breath_tween.tween_property(torso, "position:y", -magnitude, speed).as_relative()
	breath_tween.set_parallel()
	breath_tween.tween_property(torso, "size:y", magnitude, speed).as_relative()

	
