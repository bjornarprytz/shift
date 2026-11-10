class_name FacePart
extends Sprite2D

var is_in_effect = false

func blush():
	if is_in_effect:
		return
	is_in_effect = true	
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.PINK, 0.5).as_relative()
	tween.tween_property(self, "modulate", Color.WHITE, 0.5).as_relative()
	await tween.finished
	is_in_effect = false

func whiten():
	if is_in_effect:
		return
	is_in_effect = true
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 0.5).as_relative()
	await tween.finished
	is_in_effect = false

func twitch():
	if is_in_effect:
		return
	is_in_effect = true
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", 10.0, 0.1).as_relative()
	tween.tween_property(self, "rotation_degrees", -10.0, 0.1).as_relative()
	tween.tween_property(self, "rotation_degrees", 0.0, 0.1).as_relative()
	await tween.finished
	is_in_effect = false
