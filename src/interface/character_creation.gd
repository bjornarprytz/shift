extends PanelContainer

enum Selection {
	Hair,
	Ears,
	Nose
}

@onready var preview: HeadPreview = %Preview
@export var variations: AppearanceVariations

@onready var appearance: Appearance

func _ready() -> void:
	_randomize_appearance()

func _on_preview_selection_changed(selection: String) -> void:
	pass # Replace with function body.


func _on_button_pressed() -> void:
	_randomize_appearance()

func _randomize_appearance():
	appearance = variations.create_random_appearance()
	preview.apply_appearance(appearance)
