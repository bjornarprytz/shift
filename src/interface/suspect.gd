class_name Suspect
extends Node2D

@export var suspect_name: String = ["J", "S", "D", "G", "C", "L"].pick_random()
@export var walk_speed: float = 400.0

@onready var eye_r: Eye = %EyeR
@onready var eye_l: Eye = %EyeL

@onready var nose: FacePart = %Nose
@onready var mouth: Mouth = %Mouth
@onready var ear_r: FacePart = %EarR
@onready var ear_l: FacePart = %EarL
@onready var blink_timer: Timer = %BlinkTimer

@onready var body: Node2D = %Body
@onready var head: Node2D = %Head
@onready var walk_anchor: Node2D = %WalkAnchor

var part: CanvasItem

var target_pos: Vector2
var bob_tween: Tween

func _process(delta: float) -> void:
	eye_r.focal_point = get_global_mouse_position()
	eye_l.focal_point = get_global_mouse_position()
	
	if (target_pos != global_position):
		self.global_position = global_position.move_toward(target_pos, delta * walk_speed)
	elif bob_tween != null:
		_stop_bob()

func _stop_bob():
	await bob_tween.loop_finished
	bob_tween.kill()

func _on_control_mouse_entered() -> void:
	unnerve()

func _on_control_mouse_exited() -> void:
	renerve()

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

func walk_to(target_global: Vector2):
	var bob_height := 10.0
	var walk_vector = target_global - walk_anchor.global_position
	var offset = randf_range(0.01, 0.2)
	
	if (walk_vector.length() == 0):
		return
	
	target_pos = self.global_position + walk_vector
	bob_tween = create_tween()
	bob_tween.tween_interval(offset)
	bob_tween.set_loops()
	bob_tween.tween_property(body, "position:y", -bob_height, 0.1).as_relative()
	bob_tween.set_parallel()
	bob_tween.tween_property(head, "position:y", -bob_height, 0.1).as_relative()
	bob_tween.set_parallel(false)
	bob_tween.tween_property(body, "position:y", bob_height, 0.1).as_relative()
	bob_tween.set_parallel(true)
	bob_tween.tween_property(head, "position:y", bob_height, 0.1).as_relative()
	bob_tween.play()
	

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
	pass

func renerve() -> void:
	pass

func _on_blink_timer_timeout() -> void:
	await blink()
	blink_timer.wait_time = randf_range(2.0, 10.0)
	blink_timer.start()
