extends PanelContainer

signal appearance_selected(appearance: Appearance)

@onready var preview: HeadPreview = %Preview
@export var variations: AppearanceVariations

@onready var appearance: Appearance

func _ready() -> void:
	_randomize_appearance()

func _on_preview_selection_changed(selection: String) -> void:
	print("Not in use. Random is better than selection")

func _on_confirm_button_pressed() -> void:
	appearance_selected.emit(appearance)
	hide()

func _on_button_pressed() -> void:
	_randomize_appearance()

func _randomize_appearance():
	await preview.juice()
	appearance = variations.create_random_appearance()
	preview.apply_appearance(appearance)
