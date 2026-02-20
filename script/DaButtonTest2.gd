extends Button

@onready var da_button_animator: DaButtonAnimator = $DaButtonAnimator

func _ready() -> void:
	self.pressed.connect(_on_button_pressed)


func _on_button_pressed() -> void:
	da_button_animator.scale_animation()
	da_button_animator.rotation_animation()
	
