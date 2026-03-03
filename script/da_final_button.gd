extends Button

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var root_node: Node = get_tree().root.get_child(1)

var game_finished: bool = false

func _ready() -> void:
	visible = false
	DataManager.current_money_changed.connect(unlock_final)
	self.pressed.connect(end_animation)
	


func end_animation() -> void:
	game_finished = true
	gpu_particles_2d.emitting = true
	gpu_particles_2d.finished.connect(root_node.triger_end)

func unlock_final() -> void:
	#make final button appear when treshold is reach
	var appear_treshold: int = 200
	if DataManager.current_money >= appear_treshold:
		visible = true
		
	#tempo a mettre dans datamanager
	var final_cost: int = 1000
	if DataManager.current_money >= final_cost and game_finished == false:
		self.disabled = false
	else:
		self.disabled = true
