extends Button

@onready var root_node: Node = get_tree().root.get_child(1)
@onready var unlock_cost: Label = $UnlockCost
@onready var da_button_animator: DaButtonAnimator = $DaButtonAnimator
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


# target_index from datamanager is the suffix added after "DaButton" starting from 2 to 4
#used to generate next unlock button
var current_target_index = DataManager.target_index

# keep track of sound to reset it due to bug on web version
var play_count: int = 0
var saved_stream: AudioStream

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
	self.pressed.connect(play_sound)
	audio_stream_player.stream = DataManager.button_property[target_button]["sound"]
	# keep track of sound to reset it due to bug on web version
	saved_stream = audio_stream_player.stream.duplicate()
	

func update_cost_label() -> void:
	var new_cost: int = DataManager.button_property[target_button]["unlock_cost"]
	unlock_cost.text = "Cost: " + root_node.format_number(new_cost)


#disable the button if current_money < cost
func update_buyable() -> void:
	var current_money = DataManager.current_money
	if current_money >= DataManager.button_property[target_button]["unlock_cost"]:
			self.disabled = false
	else:
			self.disabled = true

func play_sound() -> void:
	audio_stream_player.play()
	#reset audio du to bug on web version
	play_count += 1
	if play_count >= 100:
		play_count = 0
		audio_stream_player.stream = saved_stream.duplicate()
