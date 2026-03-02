extends Button

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D


func _ready() -> void:
	DataManager.current_money_changed.connect(unlock_final)
	self.pressed.connect(end_animation)


func end_animation() -> void:
	gpu_particles_2d.emitting = true

func unlock_final() -> void:
	#tempo a mettre dans datamanager
	var final_cost: int = 1000
	if DataManager.current_money >= final_cost:
		self.disabled = false
	else:
		self.disabled = true
