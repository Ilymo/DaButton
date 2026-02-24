extends Button

@onready var root_node: Node = get_tree().root.get_child(1)
@onready var unlock_cost: Label = $UnlockCost

# target_index from datamanager is the suffix added after "DaButton" starting from 2 to 4
#used to generate next unlock button
var current_target_index = DataManager.target_index
@export var target_button: String = "DaButton" + str(current_target_index)

func _ready() -> void:
	#connect to the signal emited when current money change
	DataManager.current_money_changed.connect(update_buyable)
	update_buyable()
	update_cost_label()
	self.pressed.connect(root_node.unlock_dabutton.bind(target_button))
	self.pressed.connect(root_node.unlock_upgrade_button.bind(target_button))
	self.pressed.connect(root_node.next_unlock)
	self.pressed.connect(queue_free)

func update_cost_label() -> void:
	var new_cost: int = DataManager.button_property[target_button]["unlock_cost"]
	unlock_cost.text = "Cost: " + str(new_cost)


#disable the button if current_money < cost
func update_buyable() -> void:
	var current_money = DataManager.current_money
	if current_money >= DataManager.button_property[target_button]["unlock_cost"]:
			self.disabled = false
	else:
			self.disabled = true
