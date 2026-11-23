class_name SuspectBack
extends Node2D

@export var walk_speed: float = 400.0
@export var profile: Profile = Profile.new()

@onready var body: Body = %Body
@onready var head: HeadBack = %Head

var part: CanvasItem

var target_pos: Vector2 = Vector2.INF
var bob_tween: Tween

func _ready() -> void:
	body.set_breath(1.0, 4.0, 2.0, 2.0)

func apply_appearance(appearance: Appearance):
	profile.appearance = appearance
	head.apply_appearance(profile.appearance)
	body.apply_appearance(profile.appearance)

func _process(delta: float) -> void:	
	if (target_pos != Vector2.INF and target_pos != global_position):
		self.global_position = global_position.move_toward(target_pos, delta * walk_speed)
	elif bob_tween != null:
		_stop_bob()

func _stop_bob():
	await bob_tween.loop_finished
	bob_tween.kill()

func walk_to(target_global: Vector2):
	var bob_height := 10.0
	var walk_vector = target_global - global_position
	
	if (walk_vector.length() == 0):
		return
	
	target_pos = self.global_position + walk_vector
	bob_tween = create_tween()
	bob_tween.set_loops()
	bob_tween.tween_property(body, "position:y", -bob_height, 0.1).as_relative()
	bob_tween.set_parallel()
	bob_tween.tween_property(head, "position:y", -bob_height, 0.1).as_relative()
	bob_tween.set_parallel(false)
	bob_tween.tween_property(body, "position:y", bob_height, 0.1).as_relative()
	bob_tween.set_parallel(true)
	bob_tween.tween_property(head, "position:y", bob_height, 0.1).as_relative()
	bob_tween.play()
