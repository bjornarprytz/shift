class_name Spotlight
extends PointLight2D

func _on_area_area_entered(area: Area2D) -> void:
	if area.owner is Suspect:
		if area.owner.name == "Detective":
			print("detective doesn't flinch")
		area.owner.unnerve()
		


func _on_area_area_exited(area: Area2D) -> void:
	if area.owner is Suspect:
		if area.owner.name == "Detective":
			print("detective doesn't flinch")
		area.owner.renerve()
