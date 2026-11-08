class_name Eye
extends Node2D

@export var is_left_eye: bool

@onready var eye_ball: Sprite2D = %EyeBall
@onready var pupil: Sprite2D = %Pupil
@onready var upper_lid: ColorRect = %UpperLid
@onready var lower_lid: ColorRect = %LowerLid
@onready var brow: Sprite2D = %Brow

var focal_point: Vector2
var lid_gap_upper: float
var lid_gap_lower: float
var brow_angle: float

var field_of_view: float = 500.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	brow.flip_v = is_left_eye

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_place_pupil()
	_set_lids()
	_align_brow()

func _place_pupil():
	pass
	
func _set_lids():
	pass

func _align_brow():
	pass
