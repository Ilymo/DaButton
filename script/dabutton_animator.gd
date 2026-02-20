##Class that manage all the animation for DaButton
extends Node
class_name DaButtonAnimator


@export_group("scale property")
@export var scale_ease_type: Tween.EaseType = Tween.EASE_OUT
@export var scale_trans_type: Tween.TransitionType = Tween.TRANS_BACK
@export var scale_animation_duration: float = 0.07
@export var scale_amount: Vector2 = Vector2(0.8, 0.8)

@export_group("hover property")
@export var hover_scale_amount: Vector2 = Vector2(1.1, 1.1)
@export var hover_animation_duration: float = 0.05


@onready var button: Button = get_parent()

var hover_tween: Tween
var scale_tween: Tween

func _ready() -> void:
	button.pivot_offset_ratio = Vector2(0.5, 0.5)
	button.mouse_entered.connect(hover_animation.bind(true))
	button.mouse_exited.connect(hover_animation.bind(false))
	button.button_down.connect(_on_button_pressed)
	

func _on_button_pressed() -> void:
	scale_animation()


## Hover button animation, take a bool true if hovered, false if not
func hover_animation(hovered: bool) -> void:
	if hover_tween != null:
		hover_tween.kill()
	hover_tween = create_tween()
	hover_tween.tween_property(button, "scale", 
		hover_scale_amount if hovered else Vector2.ONE, hover_animation_duration)


## Scale animation when button is pressed
func scale_animation() -> void:
	if scale_tween != null:
		scale_tween.kill()
	scale_tween = create_tween().set_ease(scale_ease_type).set_trans(scale_trans_type)
	scale_tween.tween_property(button, "scale", scale_amount, scale_animation_duration)
	scale_tween.tween_property(button, "scale", Vector2.ONE, scale_animation_duration)
