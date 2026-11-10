extends Node2D

@export var suspect_name: String = ["J", "S", "D", "G", "C", "L"].pick_random()

@onready var eye_r: Eye = %EyeR
@onready var eye_l: Eye = %EyeL

@onready var nose: FacePart = %Nose
@onready var mouth: FacePart = %Mouth
@onready var ear_r: FacePart = %EarR
@onready var ear_l: FacePart = %EarL
@onready var blink_timer: Timer = %BlinkTimer

var part: CanvasItem

func _process(delta: float) -> void:
	eye_r.focal_point = get_global_mouse_position()
	eye_l.focal_point = get_global_mouse_position()

func _on_control_mouse_entered() -> void:
	unnerve()

func _on_control_mouse_exited() -> void:
	renerve()

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

func unnerve() -> void:
	var part_list = [[nose], [mouth], [ear_r, ear_l]]

	var part_group = part_list.pick_random()
	for part in part_group:
		print ("TODO: Blush %s" % part.name)

func renerve() -> void:
	pass


func _on_blink_timer_timeout() -> void:
	await blink()
	blink_timer.wait_time = randf_range(2.0, 10.0)
	blink_timer.start()
