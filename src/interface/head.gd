class_name Head
extends Node2D

@onready var bare_skin = [%Head, %Nose, %EarL, %EarR]
@onready var hair: Sprite2D = %Hair

@onready var eye_r: Eye = %EyeR
@onready var eye_l: Eye = %EyeL

@onready var cheek_r: Sprite2D = %CheekR
@onready var cheek_l: Sprite2D = %CheekL

@onready var nose: FacePart = %Nose
@onready var mouth: Mouth = %Mouth
@onready var ear_r: FacePart = %EarR
@onready var ear_l: FacePart = %EarL
@onready var head = %Head
@onready var blink_timer: Timer = %BlinkTimer

var _appeareance: Appearance

func apply_appearance(appearance: Appearance):
	_appeareance = appearance
	for s in bare_skin:
		s.modulate = appearance.skin_color
	hair.modulate = appearance.hair_color
	hair.texture = appearance.hair_style_front
	ear_l.texture = appearance.ear
	ear_r.texture = appearance.ear
	nose.texture = appearance.nose
	eye_r.apply_appearance(appearance)
	eye_l.apply_appearance(appearance)

func set_focal_point(point: Vector2):
	eye_r.focal_point = point
	eye_l.focal_point = point

func squint():
	pause_blink()
	var tween = create_tween().set_parallel()
	tween.tween_property(eye_l, "lid_gap_lower", 2.0, .1)
	tween.tween_property(eye_l, "lid_gap_upper", 2.0, .1)
	tween.tween_property(eye_r, "lid_gap_lower", 2.0, .1)
	tween.tween_property(eye_r, "lid_gap_upper", 2.0, .1)
	tween.set_parallel(false)
	tween.tween_callback(resume_blink)

func pause_blink():
	blink_timer.paused = true

func resume_blink():
	blink_timer.paused = false

func unsquint():
	pause_blink()
	var tween = create_tween().set_parallel()
	tween.tween_property(eye_l, "lid_gap_lower", _appeareance.eye_slit_gap_l, .2)
	tween.tween_property(eye_l, "lid_gap_upper", _appeareance.eye_slit_gap_l, .2)
	tween.tween_property(eye_r, "lid_gap_lower", _appeareance.eye_slit_gap_r, .2)
	tween.tween_property(eye_r, "lid_gap_upper", _appeareance.eye_slit_gap_r, .2)
	tween.set_parallel(false)
	tween.tween_callback(resume_blink)

func say(phrase: String):
	phrase = phrase.strip_edges()
	var length = phrase.length()
	if (length == 0):
		return
	var clip_length = phrase.length() * 1000 #ms
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
