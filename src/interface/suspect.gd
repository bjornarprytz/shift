extends Node2D

@export var suspect_name: String = ["J", "S", "D", "G", "C", "L"].pick_random()

@onready var eyes: RichTextLabel = $Head/Eyes
@onready var nose: RichTextLabel = $Head/Nose
@onready var mouth: RichTextLabel = $Head/Mouth
@onready var ear_l: RichTextLabel = $Head/EarL
@onready var ear_r: RichTextLabel = $Head/EarR
@onready var chin: Sprite2D = $Head/Chin

var part: CanvasItem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_control_mouse_entered() -> void:
	unnerve()

	
func _on_control_mouse_exited() -> void:
	renerve()

func unnerve() -> void:
	part = _get_random_part()
	var tween = create_tween()
	tween.tween_property(part, "self_modulate", Color.RED, 0.5)
	tween.play()

func renerve() -> void:
	var tween = create_tween()
	tween.tween_property(part, "self_modulate", Color.WHITE, 0.5)
	tween.play()

func _get_random_part() -> CanvasItem:
	return [eyes, nose, mouth, ear_l, ear_r, chin].pick_random()
