class_name Head
extends Node2D

@onready var bare_skin = [%Head, %Nose, %EarL, %EarR]
@onready var hair: Sprite2D = %Hair

@onready var eye_r: Eye = %EyeR
@onready var eye_l: Eye = %EyeL
@onready var eyes: FacePart = %Eyes

@onready var cheeks: FacePart = %Cheeks

@onready var nose: FacePart = %Nose
@onready var mouth: Mouth = %Mouth
@onready var ear_r: FacePart = %EarR
@onready var ear_l: FacePart = %EarL
@onready var head = %Head
@onready var blink_timer: Timer = %BlinkTimer
@onready var eye_tween: Tween

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
	eye_tween = create_tween().set_parallel()
	eye_tween.tween_property(eye_l, "lid_gap_lower", 2.0, .1)
	eye_tween.tween_property(eye_l, "lid_gap_upper", 2.0, .1)
	eye_tween.tween_property(eye_r, "lid_gap_lower", 2.0, .1)
	eye_tween.tween_property(eye_r, "lid_gap_upper", 2.0, .1)
	eye_tween.set_parallel(false)
	eye_tween.tween_callback(resume_blink)

func pause_blink():
	blink_timer.paused = true
	_clear_eye_tween()

func resume_blink():
	blink_timer.paused = false

func unsquint():
	pause_blink()
	eye_tween = create_tween().set_parallel()
	eye_tween.tween_property(eye_l, "lid_gap_lower", _appeareance.eye_slit_gap_l, .2)
	eye_tween.tween_property(eye_l, "lid_gap_upper", _appeareance.eye_slit_gap_l, .2)
	eye_tween.tween_property(eye_r, "lid_gap_lower", _appeareance.eye_slit_gap_r, .2)
	eye_tween.tween_property(eye_r, "lid_gap_upper", _appeareance.eye_slit_gap_r, .2)
	eye_tween.set_parallel(false)
	eye_tween.tween_callback(resume_blink)

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

func blink() -> Signal:
	_clear_eye_tween()
	var closing_phase_duration = randf_range(.05, .1)
	var opening_phase_duration = randf_range(.15, .2)
	
	eye_tween = create_tween()
	
	eye_tween.set_parallel()
	for e in [eye_l, eye_r]:
		eye_tween.tween_property(e, "lid_gap_upper", 0.0, closing_phase_duration)
		eye_tween.tween_property(e, "lid_gap_lower", 0.0, closing_phase_duration)
	
	eye_tween.set_parallel(false)
	
	for e in [eye_l, eye_r]:	
		eye_tween.tween_property(e, "lid_gap_upper", e.lid_gap_upper, opening_phase_duration)
		eye_tween.set_parallel()
		eye_tween.tween_property(e, "lid_gap_lower", e.lid_gap_lower, opening_phase_duration)
		
	return eye_tween.finished

func flinch():
	pause_blink()
	
	var x_min = Vector2(-300, 0)
	var x_max = Vector2(2000, 0)
	var y_min = Vector2(0, -300)
	var y_max = Vector2(0, 2000)
	
	var points: Array[Vector2] = []
	
	for p in range(randi_range(2, 5)):
		var v = [x_min, x_max, y_min, y_max].pick_random()
		
		var t = Vector2(v)
		if t.x == 0:
			t.x = randf_range(-300, 2000)
		else:
			t.y = randf_range(-300, 2000)
		
		points.push_back(Vector2(t))
	
	eye_tween = create_tween().set_loops()
	
	for p in points:
		eye_tween.tween_property(eye_l, "focal_point", p, .1)
		eye_tween.set_parallel()
		eye_tween.tween_property(eye_r, "focal_point", p, .1)
		eye_tween.set_parallel(false)
		eye_tween.tween_interval(randf_range(1.0, 4.0))
	
	return eye_tween.finished

func _clear_eye_tween():
	if eye_tween != null:
		eye_tween.stop()
		eye_tween = null

func _on_blink_timer_timeout() -> void:
	await blink()
	blink_timer.wait_time = randf_range(2.0, 10.0)
	blink_timer.start()
