##Class that manage all the animation for DaButton
extends Node
class_name DaButtonAnimator

@export var animation_duration: float = 0.07

@export_group("scale property")
@export var scale_ease_type: Tween.EaseType = Tween.EASE_OUT
@export var scale_trans_type: Tween.TransitionType = Tween.TRANS_BACK
@export var scale_amount: Vector2 = Vector2(0.8, 0.8)

@export_group("hover property")
@export var hover_scale_amount: Vector2 = Vector2(1.1, 1.1)
@export var hover_animation_duration: float = 0.05

@export_group("rotation property")
@export var rotation_ease_type: Tween.EaseType = Tween.EASE_OUT
@export var rotation_trans_type: Tween.TransitionType = Tween.TRANS_QUAD
@export var rotation_amount: float = 20.0


@onready var button: Button = get_parent()

var hover_tween: Tween
var scale_tween: Tween
var rotation_tween: Tween

func _ready() -> void:
	button.pivot_offset_ratio = Vector2(0.5, 0.5)
	button.mouse_entered.connect(hover_animation.bind(true))
	button.mouse_exited.connect(hover_animation.bind(false))
	button.button_down.connect(_on_button_pressed)
	

func _on_button_pressed() -> void:
	scale_animation()
	rotation_animation()

## Hover button animation, take a bool true if hovered, false if not
func hover_animation(hovered: bool) -> void:
	if hover_tween != null:
		hover_tween.kill()
	# check if another animation is running, if so, disable the hover
	if scale_tween == null or scale_tween.is_running() == false:
		hover_tween = create_tween()
		hover_tween.tween_property(button, "scale", 
			hover_scale_amount if hovered else Vector2.ONE, hover_animation_duration)


## Scale animation when button is pressed
func scale_animation() -> void:
	if scale_tween != null:
		scale_tween.kill()
	scale_tween = create_tween().set_ease(scale_ease_type).set_trans(scale_trans_type)
	scale_tween.tween_property(button, "scale", scale_amount, animation_duration)
	scale_tween.tween_property(button, "scale", Vector2.ONE, animation_duration)

## Rotation animation (shake) when button is pressed
func rotation_animation() -> void:
	if rotation_tween != null:
		rotation_tween.kill()
	rotation_tween = create_tween().set_ease(rotation_ease_type).set_trans(rotation_trans_type)
	rotation_tween.tween_property(button, "rotation_degrees", rotation_amount, animation_duration / 4)
	rotation_tween.tween_property(button, "rotation_degrees", -rotation_amount, animation_duration / 4)
	rotation_tween.tween_property(button, "rotation_degrees", rotation_amount/2, animation_duration / 4)
	rotation_tween.tween_property(button, "rotation_degrees", 0.0, animation_duration / 4)
