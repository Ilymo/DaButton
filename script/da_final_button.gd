extends Button

var jiggle_duration: int = 2

func _ready() -> void:
	play_jiggle()
	
func play_jiggle() -> void:
	pivot_offset_ratio = Vector2(0.5, 0.5)
	var position_test:= global_position
	var jiggle_tween = create_tween().set_loops().set_ease(Tween.EASE_IN_OUT)
	jiggle_tween.tween_property(self, "position", position_test + Vector2(1, 1.05), jiggle_duration / 2)
	jiggle_tween.tween_property(self, "position", position_test - Vector2(1, 1.05), jiggle_duration / 2)
	
