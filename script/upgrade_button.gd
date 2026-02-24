extends Button

@onready var root_node: Node = get_tree().root.get_child(1)
@onready var cost: Label = $Cost

@export var target_button: String = "DaButton1"

func _ready() -> void:
	#connect to the signal emited when current money change
	DataManager.current_money_changed.connect(update_buyable)
	#initialize label and buyable stat(disable/unable)
	update_cost_label()
	update_buyable()
	#func connected to game_controler
	self.pressed.connect(root_node.upgrade_lvl.bind(target_button))
	self.pressed.connect(root_node.update_upgrade_cost.bind(target_button))
	self.pressed.connect(update_cost_label)


func update_cost_label() -> void:
	var new_cost: int = DataManager.button_property[target_button]["up_cost"]
	cost.text = "Cost: " + str(new_cost)

#disable the button if current_money < cost
func update_buyable() -> void:
	var current_money = DataManager.current_money
	if current_money >= DataManager.button_property[target_button]["up_cost"]:
			self.disabled = false
	else:
			self.disabled = true
