class_name HeadPreview
extends Control

signal selection_changed(selection: String)

@onready var hair_select: ColorRect = %HairSelect
@onready var ear_select_1: ColorRect = %EarSelect1
@onready var ear_select_2: ColorRect = %EarSelect2
@onready var nose_select: ColorRect = %NoseSelect

@onready var head: Head = %Head

var focus_tween: Tween

func juice():
	var tween = create_tween()
	head.say("of")
	tween.tween_property(head, "scale", Vector2.ONE * 0.25, .1).as_relative()
	tween.tween_property(head, "scale", head.scale, .15)
	
	await tween.finished

func apply_appearance(apperaance: Appearance):
	head.apply_appearance(apperaance)

func _process(delta: float) -> void:
	head.set_focal_point(get_global_mouse_position())

func _stop_focus():
	if (focus_tween == null):
		return
	var tween_to_stop = focus_tween
	await tween_to_stop.loop_finished
	tween_to_stop.stop()

func _start_focus(rects: Array[ColorRect]):
	_stop_focus()
	focus_tween = create_tween().set_loops()
	
	for rect in rects:
		focus_tween.tween_property(rect, "modulate:a", .5, .69)
		focus_tween.set_parallel(true)
	
	focus_tween.set_parallel(false)
	
	for rect in rects:
		focus_tween.tween_property(rect, "modulate:a", .0, .69)
		focus_tween.set_parallel(true)

func _on_hair_select_mouse_entered() -> void:
	_start_focus([hair_select])

func _on_hair_select_mouse_exited() -> void:
	_stop_focus()

func _on_hair_select_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton and !event.is_pressed()):
		selection_changed.emit("hair")


func _on_ear_select_mouse_entered() -> void:
	_start_focus([ear_select_1, ear_select_2])

func _on_ear_select_mouse_exited() -> void:
	_stop_focus()

func _on_ear_select_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton and !event.is_pressed()):
		selection_changed.emit("ears")


func _on_nose_select_mouse_entered() -> void:
	_start_focus([nose_select])

func _on_nose_select_mouse_exited() -> void:
	_stop_focus()

func _on_nose_select_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton and !event.is_pressed()):
		selection_changed.emit("nose")
