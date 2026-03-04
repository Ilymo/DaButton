extends Button

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D
@onready var root_node: Node = get_tree().root.get_child(1)
@onready var camera_2d: Camera2D = %Camera2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


var game_finished: bool = false

func _ready() -> void:
	visible = false
	DataManager.current_money_changed.connect(unlock_final)
	self.pressed.connect(end_animation)
	


func end_animation() -> void:
	game_finished = true
	self.disabled = true
	camera_shake(true)
	gpu_particles_2d.emitting = true
	audio_stream_player.play()
	await gpu_particles_2d.finished
	camera_shake(false)
	root_node.triger_end()

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


func camera_shake(play: bool) -> void:
	var shake_tween = create_tween().set_loops()
	if play == true:
		shake_tween.tween_property(camera_2d, "global_rotation_degrees", randf_range(0.4, 0.6), 0.05)
		shake_tween.tween_property(camera_2d, "global_rotation_degrees", randf_range(-0.4, -0.6), 0.05)
	else:
		shake_tween.tween_property(camera_2d, "global_rotation_degrees", 0, 0.05)
		
