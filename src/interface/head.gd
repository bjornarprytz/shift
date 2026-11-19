class_name Head
extends Node2D

@onready var bare_skin = [%Head, %Nose, %EarL, %EarR]
@onready var hair: Sprite2D = %Hair

@onready var eye_r: Eye = %EyeR
@onready var eye_l: Eye = %EyeL

@onready var nose: FacePart = %Nose
@onready var mouth: Mouth = %Mouth
@onready var ear_r: FacePart = %EarR
@onready var ear_l: FacePart = %EarL
@onready var blink_timer: Timer = %BlinkTimer

func set_skintone(color: Color):
	for s in bare_skin:
		s.modulate = color

func set_hair_color(color: Color):
	hair.modulate = color

func set_focal_point(point: Vector2):
	eye_r.focal_point = point
	eye_l.focal_point = point

func say(phrase: String):
	phrase = phrase.strip_edges()
	var length = phrase.length()
	if (length == 0):
		return
	var clip_length = 5000 #ms
	var per_letter_length:float = (clip_length / length) / 1000.0
	for l in phrase:
		mouth.enounciate(l)
		await get_tree().create_timer(per_letter_length).timeout

func blink() -> void:
	var closing_phase_duration = randf_range(.05, .1)
	var opening_phase_duration = randf_range(.15, .3)
	
	var tween = create_tween()
	
	tween.set_parallel()
	for e in [eye_l, eye_r]:
		tween.tween_property(e, "lid_gap_upper", 0.0, closing_phase_duration)
		tween.tween_property(e, "lid_gap_lower", 0.0, closing_phase_duration)
	
	tween.set_parallel(false)
	
	for e in [eye_l, eye_r]:	
		tween.tween_property(e, "lid_gap_upper", e.lid_gap_upper, opening_phase_duration)
		tween.set_parallel()
		tween.tween_property(e, "lid_gap_lower", e.lid_gap_lower, opening_phase_duration)
		
	await tween.finished


func _on_blink_timer_timeout() -> void:
	await blink()
	blink_timer.wait_time = randf_range(2.0, 10.0)
	blink_timer.start()
