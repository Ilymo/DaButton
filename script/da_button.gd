extends Button

@onready var root_node: Node = get_tree().root.get_child(1)
@onready var earn: Label = $Earn
@onready var progress_bar: ProgressBar = $ProgressBar


@export var target_button: String = "DaButton1" #has to be change in inspector

func _ready() -> void:
	update_earn_label()
	self.pressed.connect(root_node.earn.bind(target_button))
	self.pressed.connect(update_earn_label)
	self.pressed.connect(cooldown_animation)
	DataManager.current_money_changed.connect(update_earn_label)


func update_earn_label() -> void:
	var new_earn: int = (
		DataManager.button_property[target_button]["earn"] *
		DataManager.button_property[target_button]["lvl"]
		)
	earn.text = "earn: +" + str(new_earn)


#start the progressbar fill animation
#disable button at the beging and unable it at the end white update_clickable func
func cooldown_animation() -> void:
	if "cooldown" in DataManager.button_property[target_button]:
		progress_bar.value = 0.0
		is_clickable(false)
		var cooldown: float = DataManager.button_property[target_button]["cooldown"]
		var tween = create_tween()
		tween.tween_property(progress_bar, "value", 100.0, cooldown)
		tween.tween_callback(is_clickable.bind(true))
	else:
		return


func is_clickable(clickable: bool) -> void:
	if clickable == false:
		self.disabled = true
	else:
		self.disabled = false
