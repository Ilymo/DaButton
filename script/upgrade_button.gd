extends Button

@onready var root_node: Node = get_tree().root.get_child(1)
@onready var cost: Label = $Cost
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var da_button_animator: DaButtonAnimator = $DaButtonAnimator
@onready var level: Label = $HBoxContainer/Level
@onready var earn: Label = $HBoxContainer/Earn


@export var target_button: String = "DaButton1"

func _ready() -> void:
	#connect to the signal emited when current money change
	DataManager.current_money_changed.connect(update_buyable)
	#initialize label and buyable stat(disable/unable)
	update_cost_and_level_label()
	update_buyable()
	#func connected to game_controler
	self.pressed.connect(root_node.update_upgrade_lvl_and_cost.bind(target_button))
	self.pressed.connect(update_cost_and_level_label)
	self.pressed.connect(play_sound)
	audio_stream_player.stream = DataManager.button_property[target_button]["sound"]
	earn.text = "+ " + str(DataManager.button_property[target_button]["earn"])


func update_cost_and_level_label() -> void:
	var new_cost: int = DataManager.button_property[target_button]["up_cost"]
	cost.text = "Cost: " + str(new_cost)
	var new_level: int =  DataManager.button_property[target_button]["lvl"]
	level.text = "lvl: " + str(new_level)

#disable the button if current_money < cost
func update_buyable() -> void:
	var current_money = DataManager.current_money
	if current_money >= DataManager.button_property[target_button]["up_cost"]:
			self.disabled = false
	else:
			self.disabled = true

func play_sound() -> void:
	audio_stream_player.play()
