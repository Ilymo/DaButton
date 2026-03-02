extends Button

@onready var root_node: Node = get_tree().root.get_child(1)
@onready var earn: Label = $Earn
@onready var progress_bar: ProgressBar = $Mask/ProgressBar


@export var target_button: String = "DaButton1" #has to be change in inspector

var dollar_particule_scene: PackedScene = preload("res://scene/dollar_particule.tscn")

func _ready() -> void:
	update_earn_label()
	self.pressed.connect(root_node.earn.bind(target_button))
	self.pressed.connect(update_earn_label)
	self.pressed.connect(cooldown_animation)
	self.pressed.connect(spawn_particule)
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


func spawn_particule() -> void:
	#instantiate and set position for the GPUParticule2D node
	var dollar_particule = dollar_particule_scene.instantiate()
	dollar_particule.position = global_position
	
	#reset scale to 1
	dollar_particule.process_material.scale = Vector2.ONE
	
	#set the amount of particule based on earn / 10
	var dollar_amount: int = (
		DataManager.button_property[target_button]["earn"] *
		DataManager.button_property[target_button]["lvl"]
		)
	
	#scale and divide amount for 0>100, 100>1000, >1000
	if dollar_amount < 100:
		dollar_amount /=10
	if dollar_amount >= 100 and dollar_amount < 1000:
		dollar_amount /= 100
		dollar_particule.process_material.scale *= 3
	if dollar_amount >= 1000:
		dollar_amount /= 1000
		dollar_particule.process_material.scale *= 6
		
	dollar_particule.amount = dollar_amount
	add_child(dollar_particule)
