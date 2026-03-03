extends Label


@onready var timer: Timer = %Timer

var total_time_in_secs: int = 0

func _ready() -> void:
	timer.timeout.connect(update_time)
	

func update_time() -> void:
	total_time_in_secs += 1
	#format time
	var m = int(total_time_in_secs / 60.0)
	var s = total_time_in_secs - m * 60
	text = '%02d:%02d' % [m, s]
