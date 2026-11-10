class_name Eye
extends Node2D

@export var is_left_eye: bool

@onready var eye_ball: Sprite2D = %EyeBall
@onready var pupil: Sprite2D = %Pupil
@onready var upper_lid: ColorRect = %UpperLid
@onready var lower_lid: ColorRect = %LowerLid
@onready var brow: Sprite2D = %Brow

var focal_point: Vector2
var lid_gap_upper: float = randf_range(2.0, 10.0)
var lid_gap_lower: float = randf_range(2.0, 10.0)
var brow_angle: float

var field_of_view: float = 200.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	brow.flip_v = is_left_eye

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_place_pupil()
	_set_lids()
	_align_brow()

func _place_pupil():
	var direction = (focal_point - global_position).normalized()
	var radius = _get_eyeball_radius()
	var limits = [-radius, radius]

	var distance = (focal_point - global_position).length()
	if distance < field_of_view:
		# Normalize field of view to the radius of the eyeball
		var normalized_distance = distance / field_of_view
		var pupil_offset = direction * radius * normalized_distance
		pupil.position = pupil_offset
	else:
		pupil.position = direction * radius
	
func _set_lids():
	upper_lid.position.y = pupil.position.y - lid_gap_upper - upper_lid.size.y
	lower_lid.position.y = lid_gap_lower + pupil.position.y

func _align_brow():
	pass


func _get_eyeball_radius() -> float:
	return eye_ball.texture.get_width() / 2.0
