extends Node2D

@onready var pb: ProgressBar = $ProgressBar
@onready var timer: Timer = $Timer

signal timeout

func _ready():
	timer.wait_time = pb.value

func _process(delta):
	#print(timer.time_left)
	pb.value = remap(timer.time_left, 0, timer.wait_time, 0, 100)

func start_timer():
	timer.start()



func _on_timer_timeout() -> void:
	timeout.emit()
