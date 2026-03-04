extends Button

@onready var root_node: Node = get_tree().root.get_child(1)
@onready var cooldown_cost: Label = $CooldownCost
@onready var level: Label = $Level
@onready var da_button_animator: DaButtonAnimator = $DaButtonAnimator
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


@export var target_button: String = "DaButton2"

func _ready() -> void:
	#connect to the signal emited when current money change
	DataManager.current_money_changed.connect(update_buyable)
	#initialize label and buyable stat(disable/unable)
	update_cost_and_level_label()
	update_buyable()
	#func connected to game_controler
	self.pressed.connect(root_node.update_cd_lvl_and_cost.bind(target_button))
	self.pressed.connect(update_cost_and_level_label)
	self.pressed.connect(play_sound)
	audio_stream_player.stream = DataManager.button_property[target_button]["sound"]


func update_cost_and_level_label() -> void:
	var new_cost: int = DataManager.button_property[target_button]["cd_cost"]
	cooldown_cost.text = "Cost: " + str(new_cost)
	var new_level: int =  DataManager.button_property[target_button]["cd_lvl"]
	level.text = "lvl: " + str(new_level) + "/" + str(DataManager.button_property[target_button]["max_cd_lvl"])

#disable the button if current_money < cost
func update_buyable() -> void:
	var current_money = DataManager.current_money
	var current_level: int =  DataManager.button_property[target_button]["cd_lvl"]
	var max_level: int = DataManager.button_property[target_button]["max_cd_lvl"]
	if current_money >= DataManager.button_property[target_button]["cd_cost"] and current_level < max_level:
			self.disabled = false
	else:
			self.disabled = true


func play_sound() -> void:
	audio_stream_player.play()
